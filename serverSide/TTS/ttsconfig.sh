tts --text "Text for TTS" \
    --model_name tts_models/multilingual/multi-dataset/xtts_v2 \
    --vocoder_name vocoder_models/universal/libri-tts/wavegrad \
    --out_path /home/lulu/githubApps/PersonalProjects/pythonVirtualEnviroment/practiceEnviroment


# figure out variables to set for modelname vocoder outpath and set up config yaml file
#tts --text "Text for TTS" \
#    --model_name "<type>/<language>/<dataset>/<model_name>" \
#    --vocoder_name "<type>/<language>/<dataset>/<model_name>" \
#    --out_path folder/to/save/output/
