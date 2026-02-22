if [[ "$OSTYPE" == "linux-android"* ]]; then
	export LEDGER_FILE="$HOME/storage/shared/Documents/Ledger/2026.hledger"
	alias importer="ruby $HOME/storage/shared/Documents/Ledger/import/notifications.rb"
fi
