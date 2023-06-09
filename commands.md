# Commands

Here are the commands that I have used on the python files in the `commands` directory. Those files are mostly copied from the examples directory on the Hugging Face repository.

For the commands to work, you will need to have a `data` directory in which the SQuAD-Dutch is saved. 

Each commands uses the option `--use_mps_device`. This option is only necessary when using an ARM Mac chip. Otherwise this option can be removed. I used this option, so I left it in the commands.

## Training `SQuAD + Bertje`

The following command will fine-tune Bertje with the SQuAD-Dutch dataset. Bertje is downloaded from Hugging Face.

``` shell
python ./commands/question-answering/run_qa.py \
--model_name_or_path GroNLP/bert-base-dutch-cased \
--output_dir ./bertje-squad-v2.0-command \
--do_train \
--train_file ./data/train-v2.0.json \
--do_eval \
--validation_file ./data/dev-v2.0.json \
--do_predict \
--test_file ./data/dev-v2.0.json \
--overwrite_output_dir \
--version_2_with_negative \
--use_mps_device 
```

## Training `SNLI + Bertje`

``` shell
python ./commands/text-classification/run_glue.py \
--model_name_or_path GroNLP/bert-base-dutch-cased \
--dataset_name GroNLP/ik-nlp-22_transqe \
--output_dir bertje-eSNLI-command \
--do_train \
--do_eval \
--overwrite_output_dir \
--learning_rate 5e-07 \
--use_mps_device
```

## Training `SQuAD + SNLI + Bertje`

``` shell
python ./commands/question-answering-snli/run_qa.py \
--model_name_or_path ./bertje-eSNLI-command \
--output_dir ./bertje-squad-v2.0-eSNLI-command \
--do_train \
--train_file ./data/train-v2.0.json \
--do_eval \
--validation_file ./data/dev-v2.0.json \
--do_predict \
--test_file ./data/dev-v2.0.json \
--overwrite_output_dir \
--version_2_with_negative \
--use_mps_device
```