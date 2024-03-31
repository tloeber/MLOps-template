#  Need to explicitly source bashrc, which is omitted by default if specifying custom init file.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Automatically export all variables defined. Otherwise, sourcing .env file only exports to shell used
# by load_env_variables.sh, but not to the parent shell (VSCode integrated terminal).
set -a

# Don't check if .env file exists, as we treat it as mandatory if vscode workspace specifies to source it
source .env
echo "Sourced $(pwd)/.env"

# Turn off automatic export again
set +a