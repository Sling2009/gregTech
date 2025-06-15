#!/bin/bash

set -x

# update_server_jsons() {
#   local player_list="$1"
#   local file_path="$2"
#   echo "update ${file_path}"
#   # Split die Spieler in ein Array
#   IFS=',' read -ra players <<<"$player_list"
#
#   # Erstelle ein leeres JSON-Array
#   local json_array="[]"
#
#   # Füge für jeden Spieler ein Objekt hinzu
#   for player in "${players[@]}"; do
#     echo "add user ${player}"
#     json_array=$(echo "$json_array" | jq --arg name "$player" '. + [{"uuid": null, "name": $name}]')
#   done
#
#   # Schreibe das Ergebnis in die Datei
#   echo "$json_array" >"$file_path"
# }

# Prüfen, ob HOME_DIR leer ist (kein Inhalt)
if [ -z "$(ls -A "$HOME_DIR" 2>/dev/null)" ]; then
  echo "Verzeichnis $HOME_DIR ist leer. Lade und entpacke Server-Paket..."

  # Download
  curl -L "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GREGTECH_VERSION}_Server_Java_17-21.zip" -o server.zip

  # Entpacken nach HOME_DIR
  unzip server.zip -d "$HOME_DIR"

  # Startscript ausführbar machen
  chmod +x "$HOME_DIR/startserver-java9.sh"

  # Zip löschen
  rm server.zip
else
  echo "Verzeichnis $HOME_DIR ist nicht leer, überspringe Download und Entpacken."
fi

#setze eula.txt
if [[ "$EULA" = "true" ]]; then
  echo "eula=true" >"${HOME_DIR}"/eula.txt
else
  echo "you have to accept EULA to install."
  exit 10
fi

# update_server_jsons "${WHITE_LIST}" "${HOME_DIR}"/whitelist.json
# update_server_jsons "${OPS_LIST}" "${HOME_DIR}"/ops.json

# Server starten
./startserver-java9.sh || {
  echo "Fehler beim Ausführen von startserver-java9.sh"
  exit 11
}

exit 0
