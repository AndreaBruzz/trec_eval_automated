    #!/bin/bash

    # Exit immediately if a command exits with a non-zero status
    set -e

    # ---------------------
    # CONFIGURATION
    # ---------------------
    TREC_EVAL_DIR="./trec_eval"
    TREC_EVAL_BIN="$TREC_EVAL_DIR/trec_eval"

    RUNS_DIR="./runs"
    QRELS_DIR="./qrels"
    EVALS_DIR="./evals"

    # ---------------------
    # ARGUMENT PARSING
    # ---------------------
    if [ "$#" -lt 1 ]; then
        echo "Usage: $0 <qrels_file> [trec_eval arguments]"
        echo "Trec eval arguments:"
        "$TREC_EVAL_BIN" -h
        exit 1
    fi

    QRELS_FILE="$1"
    shift
    ARGS="$@"

    # ---------------------
    # BUILD TREC_EVAL IF NEEDED
    # ---------------------
    cd "$TREC_EVAL_DIR"
    if [ ! -f "trec_eval" ]; then
        echo "trec_eval binary not found. Building with make..."
        make
    fi
    cd ..

    # ---------------------
    # CREATE OUTPUT DIR IF MISSING
    # ---------------------
    mkdir -p "$EVALS_DIR"

    # ---------------------
    # RUN EVALUATION
    # ---------------------
    for runfile in "$RUNS_DIR"/*.txt; do
        [ -e "$runfile" ] || continue

        base=$(basename "$runfile")
        echo "Evaluating $base..."

        "$TREC_EVAL_BIN" $ARGS "$QRELS_DIR/$QRELS_FILE" "$runfile" > "$EVALS_DIR/$base"
        mv "$runfile" "$RUNS_DIR/old/"
    done

    echo "All evaluations complete. Results are saved in $EVALS_DIR/"
