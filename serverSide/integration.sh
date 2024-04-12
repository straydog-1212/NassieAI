#! /bin/bash

#activate python virtual enviroment
source ~/.nassieAI/pythonVenv/bin/activate


# Parse JSON using Python
json_data=$(python -c 'import json; data=json.load(open("./serverSideConfig.json")); print(data["language"]); print(data["modelname"]); print(data["threads"]); print(data["vocoderModelName"]); print(data["outputPath"])')

# Split the output into separate variables
read -r language modelname threads vocoderModelName outputPath <<< "$json_data"

echo "language: $language"
echo "threads: $threads"

echo "ollamaModelName: $ollamaModelName"

echo "Vocoder Model Name: $vocoderModelName"
echo "Output Path: $outputPath"
echo "ttsModelName: $ttsModelName"


whisper --model base  --output_format txt --verbose false --language "$language"  .webrtcOuPut.ogg > .whisperOutPut.txt
# for language use "none" to do language detection
# use the flag --threads to specify thread count of cpu to be used for whisper

if [$? -eq 0];
        echo "Whisper has Proccessed audio to text."
else
        echo "Whisper had a non zero exit status. Something is wrong with Whisper."
fi

# cleans up whisper file to get rid of the time stamps
sed -i 's/\[[0-9:.]* --> [0-9:.]*\]//g' .whisperOutPut.txt

# ollama reads file output by whisper and uses it to do whatever process was required
ollama run "$ollamaModelName" "$cat .whisperOutPut.txt" > .ollamaOutPut.txt
if [$? -eq 0];
        echo "$ollamaModelName has processed text."
else
        echo "ollama had a non zero exit status. Something is wrong with ollama config. Edit serverSideConfig.json to fix issue"
fi

#text to speech reads ollamas file  and outputs an audio file
tts --text "$(cat .ollamaoutput.txt)" \
    --model_name "$ttsModelName" \
    --vocoder_name "$vocoderName" \
    --out_path "$outpath"
if [$? -eq 0];
        echo "tts has processed text file to audio"
else
        echo "tts had a non zero exit status. Something is wrong with tts setup"
