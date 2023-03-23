build:
    cargo build

test:
    cargo test

lint:
    cargo clippy --all-targets -- -D warnings

optimize:
    if [[ $(uname -m) =~ "arm64" ]]; then \
    docker run --rm -v "$(pwd)":/code \
        --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
        --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
        --platform linux/arm64 \
        cosmwasm/rust-optimizer-arm64:0.12.12; else \
    docker run --rm -v "$(pwd)":/code \
        --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
        --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
        --platform linux/amd64 \
        cosmwasm/rust-optimizer:0.12.12; fi
    mkdir -p tests/wasms
    if [[ $(uname -m) =~ "arm64" ]]; then \
    cp artifacts/polytone_note-aarch64.wasm tests/wasms/polytone_note.wasm && \
    cp artifacts/polytone_voice-aarch64.wasm tests/wasms/polytone_voice.wasm && \
    cp artifacts/polytone_tester-aarch64.wasm tests/wasms/polytone_tester.wasm && \
    cp artifacts/polytone_proxy-aarch64.wasm tests/wasms/polytone_proxy.wasm \
    ;else \
    cp artifacts/polytone_note.wasm tests/wasms/ && \
    cp artifacts/polytone_voice.wasm tests/wasms/ && \
    cp artifacts/polytone_tester.wasm tests/wasms/ && \
    cp artifacts/polytone_proxy.wasm tests/wasms/ \
    ;fi

simtest: optimize
    cd tests/simtests && go test ./...

# ${f    <-- from variable f
#   ##   <-- greedy front trim
#   *    <-- matches anything
#   /    <-- until the last '/'
#  }
# <https://stackoverflow.com/a/3162500>
schema:
    start=$(pwd); \
    for f in ./contracts/*; \
    do \
    echo "generating schema for ${f##*/}"; \
    cd "$f" && cargo schema && cd "$start" \
    ;done
    echo "generating schema for polytone-tester"; \
    cd tests/polytone-tester && cargo schema && cd -