
if [ -z "$1" ]; then
  echo Script must be run with a name of the sattelite
  exit 1
fi

cd wyoming-satellite

screen -dmS wyoming-satellite script/run --debug \
  --name "$1" \
  --uri 'tcp://0.0.0.0:10700' \
  --mic-command 'arecord -D pulse -r 16000 -c 1 -f S16_LE -t raw' \
  --snd-command 'aplay -D pulse -r 22050 -c 1 -f S16_LE -t raw' \
  --wake-uri 'tcp://127.0.0.1:10400' \
  --wake-word-name 'jarvis_v2' \
  --awake-wav ../wav/beep_hi.wav \
  --done-wav ../wav/beep_lo.wav \
  --timer-finished-wav ../wav/beep_error.wav
cd ..

sleep 2s


cd wyoming-openwakeword
screen -dmS wyoming-openwakeword script/run --debug \
  --custom-model-dir '../wakewords' \
  --preload-model 'jarvis_v2' \
  --threshold 0.5 \
  --uri 'tcp://127.0.0.1:10400'
cd ..

