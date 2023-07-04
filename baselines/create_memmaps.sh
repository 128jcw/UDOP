#!/bin/bash
DATASETS_ROOT='.' #"/scratch/jcw/DUE/aws_neurips_time/kleister-charity/train"
TOKENIZER='t5-base' #"/scratch/jcw/DUE/aws_neurips_time/kleister-charity/train"
MAX_LENGTHS=(1024 6144 6144 1024 4096 1024 6144)
TRAIN_STRATEGIES=(all_items concat all_items all_items concat all_items all_items)
DATASETS='KleisterCharity' #(DocVQA PWC DeepForm TabFact WikiTableQuestions InfographicsVQA KleisterCharity)
OCRS=(microsoft_cv tesseract djvu)
#KleisterCharity/png/0595f67c16ccddcae2ce6e8afac50246

for task_idx in "${!DATASETS[@]}"
do
    mkdir -p memmaps/$task_directory
    for ocr_engine in "${OCRS[@]}"
    do
        if ! grep -q "\"tool_name\": \"$ocr_engine\"" $DATASETS_ROOT/${DATASETS[task_idx]}/documents_content.jsonl; then
            echo "Skipping ${DATASETS[task_idx]}/$ocr_engine"
            continue
        fi
        echo "Producing memmaps for ${DATASETS[task_idx]}/$ocr_engine..."
        TOKENIZERS_PARALLELISM=false ./benchmarker/cli/l5/create_memmaps.py \
            --dataset_path_or_name $DATASETS_ROOT/${DATASETS[task_idx]}/ \
            --model_path $TOKENIZER \
            --memmap_path memmaps/${DATASETS[task_idx]}/$ocr_engine \
            --max_encoder_length ${MAX_LENGTHS[task_idx]} \
            --segment_levels "(tokens,pages)" \
            --processes 20 \
            --ocr_engine $ocr_engine \
            --train_strategy ${TRAIN_STRATEGIES[task_idx]} \
            --dev_strategy concat \
            --test_strategy concat \
            --use_fast_tokenizer
    done
done
