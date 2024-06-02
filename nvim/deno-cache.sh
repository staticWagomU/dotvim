#!/bin/bash

find ~/.local/share/nvim/site/pack/deps/ -name "*.ts" -exec deno cache --reload {} +
