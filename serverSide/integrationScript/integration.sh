#! /bin/bash

# Parse JSON using Python
json_data=$(python -c 'import json; data=json.load(open("your_file.json")); print(data["language"]); print(data["modelname"]); print(data["threads"]); print(data["vocoderModelName"]); print(data["outputPath"])')

# Split the output into separate variables
read -r language modelname threads vocoderModelName outputPath <<< "$json_data"

echo "Language: $language"
echo "Model Name: $modelname"
echo "Threads: $threads"
echo "Vocoder Model Name: $vocoderModelName"
echo "Output Path: $outputPath"


whisper  --language "$lang" webrtcOuPut.ogg > whisperOutPut.txt
# for language use "none" to do language detection
# use the flag --threads to specify thread count of cpu to be used for whisper

# cleans up whisper file to get rid of the time stamps
sed -i 's/\[[0-9:.]* --> [0-9:.]*\]//g' whisperOutPut.txt

# ollama reads file output by whisper and uses it to do whatever process was required
ollama run "$modelname" "$cat whisperOutPut.txt" > ollamaOutPut.txt

#text to speech reads ollamas file  and outputs an audio file
tts --text "$(cat ollamaoutput.txt)" \
    --model_name "$modelname" \
    --vocoder_name "$vocodername" \
    --out_path "$outpath"

