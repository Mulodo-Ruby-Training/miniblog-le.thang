# Status OK
STATUS_OK = 200

# Validate error
ERROR_VALIDATE = [1000,'Validate data error']

# ============= System error ============= #
ERROR_SYSTEM = [9001, 'System error was occurred. Please try again later.']
ERROR_DATABASE = [9002,"Database error was occurred. Please try again later."]
ERROR_OBJECT_TROUBLE = [9004,"The object have trouble or null can't access."]
ERROR_TIME_LIMITED = [9005,"Time limit Exceeded. Refine your search to locate more entries."]

# ============= Authentication error ============= #
# Check login false, you are already logged in?
ERROR_NOT_YET_LOGIN = [1001,'Check login false, you are already logged in?']

# Token expired
ERROR_TOKEN_EXPIRED = [1002,'Token has expired']

# Goto login after fail link
ERROR_FAILED_LINK = [1003,"This link is generated when most errors occur. The link will send the users to the original Login URL page. "]

# Session is expired
ERROR_SESSION_EXPIRED = [1004,"Session is expired"]

# Check users name or password
ERROR_USERNAME_OR_PASSWORD_FAILED = [1005,"The password or username entered is invalid."]

# Your permission isn't enough
ERROR_PERMISSION_NOT_ENOUGH = [1006,"Your permission isn't enough"]

# Account already exists. Do you want to log out.
ERROR_ALREADY_LOGGED_IN = [1007,"Account already exists. Do you want to log out."]

# ============= User Error Message ============= #
# User existed
ERROR_USER_EXISTED = [2001,'This username is already in used.']

# Create users failed
ERROR_INSERT_USER = [2002,'Create users failed.']

# Get information of all users failed
ERROR_GET_USER_INFO_FAILED = [2003,'Get information of all users failed.']

# Update users failed
ERROR_UPDATE_USER = [2005,'Update users failed.']

# Change password failed
ERROR_CHANGED_PASSWORD = [2006,'Change password failed.']

# Could not login
ERROR_LOGIN_FAILED = [2007,'Could not login.']

# Get information all post of the users

ERROR_GET_INFO_POST_OF_USER= [2008,'Get information all post of the users.']

# Could not change permission.
ERROR_PERMISSION_CHANGED = [2009,'Could not change permission.']

# Search failed.
ERROR_SEARCH_FAILED = [2010,'Search failed.']

# ============= Post Error Message ============= #

# ============= Comment Error Message ============= #

# ============= Category Error Message ============= #