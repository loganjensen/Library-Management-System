# Library-Loan-System-

# First install the isolated package environment
# manager if it isn't already available
pip install virtualenv

# Next create a new virtual environment
virtualenv --python=python3 venv

# Activate the virtual environment in Bash.
# There are other scripts for other shells, like activate.fish and .ps1
source venv/bin/activate

# Once inside venv, pip will install packages isolated from your system
pip install -r requirements.txt

# The application should now be ready to run. To run in debug mode, use
FLASK_ENV=development flask run
