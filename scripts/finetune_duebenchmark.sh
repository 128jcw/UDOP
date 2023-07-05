PYTHONPATH="." python benchmarker/cli/l5/train.py \
--gpus 1 \
--model_name_or_path "udop-unimodel-large-224" \
--relative_bias_args '[{"type":"1d"},{"type":"horizontal"},{"type":"vertical"}]' \
--model_type 'UdopUnimodel' \
--data_dir './' \
--train_data_dir '/input/memmaps_4096/KleisterCharity/tesseract/train' \
--val_data_dir '/input/memmaps_4096/KleisterCharity/tesseract/dev' \
--test_data_dir  '/input/memmaps_4096/KleisterCharity/tesseract/test' \
--im_dir '/input/Kleister-Charity/pdf' \
--max_source_length 4096 \
--img_conf '{"size": 224}' \
--max_target_length 256 \
--eval_max_gen_length 256 \
--dropout_rate 0.15 \
--label_smoothing 0 \
--num_workers 12 \
--train_batch_size 1 \
--eval_batch_size 1 \
--accumulate_grad_batches 1 \
--max_epochs 30 \
--val_check_interval 0.2 \
--output_dir './KC4096' \
--warmup_steps 100 \
--learning_rate 5e-5 \
--lr_scheduler constant \
--val_metric loss \
--do_train \
--do_predict \
--additional_data_fields doc_id label_name \
--segment_levels tokens pages \
--optimizer adamw \
--weight_decay 1e-5 \
--adam_epsilon 1e-8 \
--trim_batches \
--accelerator ddp \
--seed 4 \
--early_stopping_patience 20 \
--overwrite_output_dir 
