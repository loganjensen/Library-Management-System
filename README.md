# Library-Loan-System
```bash
A simple front-end/back-end for a small university library loan system.
```

```bash
Note: You must be connected to the OSU VPN for the database queries to work.
```

## Installation

```bash
First install the isolated package environment
manager if it isn't already available
pip install virtualenv
```

```bash
Next create a new virtual environment
virtualenv --python=python3 venv
```

```bash
# Activate the virtual environment in Bash.
# There are other scripts for other shells, like activate.fish and .ps1
source venv/bin/activate
```

```bash
# Once inside venv, pip will install packages isolated from your system
pip install -r requirements.txt
```
```bash
# The application should now be ready to run. To run in debug mode, use
FLASK_ENV=development flask run
```
