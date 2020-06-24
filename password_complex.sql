Rem  Function: "string_distance" - Calculates the Levenshtein distance 
Rem            between two strings 's' and 't'.

CREATE OR REPLACE FUNCTION string_distance
(s varchar2,
 t varchar2)
RETURN integer IS
   s_len    INTEGER := NVL (length(s), 0);
   t_len    INTEGER := NVL (length(t), 0);
   TYPE arr_type is TABLE OF NUMBER INDEX BY BINARY_INTEGER;
   d_col    arr_type ;
   dist     INTEGER := 0;
BEGIN
   IF s_len = 0 THEN
      dist := t_len;
   ELSIF t_len = 0 THEN
      dist := s_len;
   ELSE
      FOR j IN 1 .. (t_len+1) * (s_len+1) - 1 LOOP
          d_col(j) := 0 ;
      END LOOP;
      FOR i IN 0 .. s_len LOOP
          d_col(i) := i;
      END LOOP;
      FOR j IN 1 .. t_len LOOP
          d_col(j * (s_len + 1)) := j;
      END LOOP;

      FOR i IN 1.. s_len LOOP
        FOR j IN 1 .. t_len LOOP
          IF substr(s, i, 1) = substr(t, j, 1)
          THEN
             d_col(j * (s_len + 1) + i) := d_col((j-1) * (s_len+1) + i-1) ;
          ELSE
             d_col(j * (s_len + 1) + i) := LEAST (
                       d_col( j * (s_len+1) + (i-1)) + 1,      -- Deletion
                       d_col((j-1) * (s_len+1) + i) + 1,       -- Insertion
                       d_col((j-1) * (s_len+1) + i-1) + 1 ) ;  -- Substitution
          END IF ;
        END LOOP;
      END LOOP;
      dist :=  d_col(t_len * (s_len+1) + s_len);
   END IF;

   RETURN (dist);
END;
/

Rem *************************************************************************
Rem BEGIN Password Verification Functions
Rem *************************************************************************


Rem  Function: "complexity_check" - Verifies the complexity 
Rem            of a password string.
Rem 
Rem  If not NULL, each of the following parameters specifies the minimum
Rem  number of characters of the corresponding type.
Rem  chars   -  All characters (i.e. string length)
Rem  letter  -  Alphabetic characters A-Z and a-z
Rem  upper   -  Uppercase letters A-Z
Rem  lower   -  Lowercase letters a-z
Rem  digit   -  Numeric characters 0-9
Rem  special -  All characters not in A-Z, a-z, 0-9 except DOUBLE QUOTE
Rem             which is a password delimiter


CREATE OR REPLACE FUNCTION complexity_check
(password varchar2,
 chars integer := NULL,
 letter integer := NULL,
 upper integer := NULL,
 lower integer := NULL,
 digit integer := NULL,
 special integer := NULL)
RETURN boolean IS
   digit_array varchar2(10) := '0123456789';
   alpha_array varchar2(26) := 'abcdefghijklmnopqrstuvwxyz';
   cnt_letter integer := 0;
   cnt_upper integer := 0;
   cnt_lower integer := 0;
   cnt_digit integer := 0;
   cnt_special integer := 0;
   delimiter boolean := FALSE;
   len INTEGER := NVL (length(password), 0);
   i integer ;
   ch CHAR(1);
BEGIN
   -- Check that the password length does not exceed 2 * (max DB pwd len)
   -- The maximum length of any DB User password is 128 bytes.
   -- This limit improves the performance of the Edit Distance calculation
   -- between old and new passwords.
   IF len > 256 THEN
      raise_application_error(-20020, 'Password length more than 256');
   END IF;

   -- Classify each character in the password.
   FOR i in 1..len LOOP
      ch := substr(password, i, 1);
      IF ch = '"' THEN
         delimiter := TRUE;
      ELSIF instr(digit_array, ch) > 0 THEN
         cnt_digit := cnt_digit + 1;
      ELSIF instr(alpha_array, NLS_LOWER(ch)) > 0 THEN
         cnt_letter := cnt_letter + 1;
         IF ch = NLS_LOWER(ch) THEN
            cnt_lower := cnt_lower + 1;
         ELSE
            cnt_upper := cnt_upper + 1;
         END IF;
      ELSE
         cnt_special := cnt_special + 1;
      END IF;
   END LOOP;

   IF delimiter = TRUE THEN
      raise_application_error(-20012, 'password must NOT contain a ' 
                               || 'double-quote character, which is '
                               || 'reserved as a password delimiter');
   END IF;
   IF chars IS NOT NULL AND len < chars THEN
      raise_application_error(-20001, 'Password length less than ' ||
                              chars);
   END IF;
   IF letter IS NOT NULL AND cnt_letter < letter THEN
      raise_application_error(-20022, 'Password must contain at least ' ||
                                      letter || ' letter(s)');
   END IF;
   IF upper IS NOT NULL AND cnt_upper < upper THEN
      raise_application_error(-20023, 'Password must contain at least ' ||
                                      upper || ' uppercase character(s)');
   END IF;
   IF lower IS NOT NULL AND cnt_lower < lower THEN
      raise_application_error(-20024, 'Password must contain at least ' ||
                                      lower || ' lowercase character(s)');
   END IF;
   IF digit IS NOT NULL AND cnt_digit < digit THEN
      raise_application_error(-20025, 'Password must contain at least ' ||
                                      digit || ' digit(s)');
   END IF;
   IF special IS NOT NULL AND cnt_special < special THEN
      raise_application_error(-20026, 'Password must contain at least ' ||
                                      special || ' special character(s)');
   END IF;

   RETURN(TRUE);
END;
/



Rem Function: "verify_function_11G" - provided from 11G onwards.
Rem 
Rem This function makes the minimum complexity checks like
Rem the minimum length of the password, password not same as the
Rem username, etc. The user may enhance this function according to
Rem the need.

CREATE OR REPLACE FUNCTION verify_function_11G
(username varchar2,
 password varchar2,
 old_password varchar2)
RETURN boolean IS 
   differ integer;
   db_name varchar2(40);
   i integer;
   i_char varchar2(10);
   simple_password varchar2(10);
   reverse_user varchar2(32);
BEGIN 
   IF NOT complexity_check(password, chars => 8, letter => 1, digit => 1,special =>1) THEN
      RETURN(FALSE);
   END IF;

   -- Check if the password is same as the username or username(1-100)
   IF NLS_LOWER(password) = NLS_LOWER(username) THEN
     raise_application_error(-20002, 'Password same as or similar to user');
   END IF;
   FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if NLS_LOWER(username)|| i_char = NLS_LOWER(password) THEN
        raise_application_error(-20005, 'Password same as or similar to ' || 
                                        'username ');
      END IF;
   END LOOP;

   -- Check if the password is same as the username reversed
   FOR i in REVERSE 1..length(username) LOOP
     reverse_user := reverse_user || substr(username, i, 1);
   END LOOP;
   IF NLS_LOWER(password) = NLS_LOWER(reverse_user) THEN
     raise_application_error(-20003, 'Password same as username reversed');
   END IF;

   -- Check if the password is the same as server name and or servername(1-100)
   select name into db_name from sys.v$database;
   if NLS_LOWER(db_name) = NLS_LOWER(password) THEN
      raise_application_error(-20004, 'Password same as or similar ' ||
                                      'to server name');
   END IF;
   FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if NLS_LOWER(db_name)|| i_char = NLS_LOWER(password) THEN
        raise_application_error(-20005, 'Password same as or similar ' || 
                                        'to server name ');
      END IF;
   END LOOP;

   -- Check if the password is too simple. A dictionary of words may be
   -- maintained and a check may be made so as not to allow the words
   -- that are too simple for the password.
   IF NLS_LOWER(password) IN ('welcome1', 'database1', 'account1', 'user1234',
                              'password1', 'oracle123', 'computer1', 
                              'abcdefg1', 'change_on_install') THEN
      raise_application_error(-20006, 'Password too simple');
   END IF;

   -- Check if the password is the same as oracle (1-100)
    simple_password := 'oracle';
    FOR i IN 1..100 LOOP
      i_char := to_char(i);
      if simple_password || i_char = NLS_LOWER(password) THEN
        raise_application_error(-20006, 'Password too simple ');
      END IF;
    END LOOP;

   -- Check if the password differs from the previous password by at least
   -- 3 letters
   IF old_password IS NOT NULL THEN
     differ := string_distance(old_password, password);
     IF differ < 3 THEN
         raise_application_error(-20011, 'Password should differ from the ' ||  
                                 'old password by at least 3 characters');
     END IF;
   END IF;

   RETURN(TRUE);
END;
/

GRANT EXECUTE ON verify_function_11G TO PUBLIC;
ALTER PROFILE QNB_PROFILE LIMIT PASSWORD_VERIFY_FUNCTION verify_function_11G;



