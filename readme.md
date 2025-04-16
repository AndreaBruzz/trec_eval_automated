# Automated TREC Eval

**Note:** This system has been developed and tested **only on Linux**. You must have `make` installed to compile the `trec_eval` module.

## Overview

[`trec_eval`](https://github.com/usnistgov/trec_eval) is a powerful tool for evaluating search engine results, especially useful when participating in [LongEval CLEF Labs](https://clef-longeval.github.io/) or working with training data from known datasets.

However, when you're stress-testing and generating multiple runs, it can become tedious to manually monitor and trigger evaluations—especially if each evaluation takes several minutes. This tool automates that process so you can queue multiple runs and focus on other tasks while evaluations happen in the background.

## Usage

To run an evaluation, simply execute:

```bash
./run.sh <qrels_file.txt> [trec_eval native arguments]
```

This will automatically process all new runs placed in the `runs/` directory. Using the Ground Truth file specified and stored into `qrels/` directory

## Project Structure

- `runs/`: Place your run files here for evaluation.
- `runs/old/`: After evaluation, run files are automatically moved here to keep things tidy.
- `evals/`: Each evaluation generates a `.txt` file here with the same name as the original run file. **Note:** Re-evaluating a run will overwrite the existing result file.
- `qrels/`: Place your qrels files here.
