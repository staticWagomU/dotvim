import { BaseConfig } from "https://deno.land/x/ddc_vim@v4.0.5/types.ts";
import { ConfigArguments } from "https://deno.land/x/ddc_vim@v4.0.5/base/config.ts";

export class Config extends BaseConfig {
  // deno-lint-ignore require-await
  override async config(args: ConfigArguments): Promise<void> {
    const commonSources = [
      "skkeleton",
      "around",
      "file",
    ];

    args.contextBuilder.patchGlobal({
      ui: "pum",
      autoCompleteEvents: [
        "InsertEnter",
        "TextChangedI",
        "TextChangedP",
        "CmdlineEnter",
        "CmdlineChanged",
        "TextChangedT",
      ],
      sources: commonSources,
      cmdlineSources: {
        ":": ["cmdline", "cmdline-history", "around"],
        "/": ["around", "line"],
        "?": ["around", "line"],
        "=": ["input"],
      },
      sourceOptions: {
        _: {
          ignoreCase: true,
          matchers: ["matcher_head", "matcher_prefix", "matcher_length"],
          sorters: ["sorter_rank"],
          converters: ["converter_remove_overlap"],
          timeout: 1000,
          minKeywordLength: 1,
          maxItems: 50,
        },
        around: {
          mark: "[Around]",
        },
        buffer: {
          mark: "[Buffer]",
        },
        cmdline: {
          mark: "[Cmdline]",
          forceCompletionPattern: "\\S/\\S*|\\.\\w*",
        },
        input: {
          mark: "[Input]",
          forceCompletionPattern: "\\S/\\S*",
          isVolatile: true,
        },
        line: {
          mark: "[Line]",
        },
        lsp: {
          mark: "[LSP]",
          forceCompletionPattern: "\\.\\w*|::\\w*|->\\w*",
          dup: "force",
          isVolatile: true,
          converters: ["converter_kind_labels"],
        },
        file: {
          mark: "[File]",
          isVolatile: true,
          minAutoCompleteLength: 5,
          forceCompletionPattern: "\\S/\\S*",
        },
        "cmdline-history": {
          mark: "[History]",
          sorters: [],
        },
        skkeleton: {
          mark: "[Skkeleton]",
          matchers: ["skkeleton"],
          sorters: [],
          minAutoCompleteLength: 1,
          isVolatile: true,
        },
      },
      sourceParams: {
        buffer: {
          requireSameFiletype: false,
          limitBytes: 50000,
          fromAltBuf: true,
          forceCollect: true,
        },
        file: {
          filenameChars: "[:keyword:].",
        },
        "shell-native": {
          shell: "fish",
        },
      },
      filterParams: {
        converter_kind_labels: {
          kindLabels: {
            Text: "",
            Method: "",
            Function: "",
            Constructor: "",
            Field: "",
            Variable: "",
            Class: "",
            Interface: "",
            Module: "",
            Property: "",
            Unit: "",
            Value: "",
            Enum: "",
            Keyword: "",
            Snippet: "",
            Color: "",
            File : '󰈙 ',
            Reference: "",
            Folder: "",
            EnumMember: "",
            Constant: "",
            Struct: "",
            Event: "",
            Operator: "",
            TypeParameter: "",
          },
          kindHLGroups: {
            Text: "String",
            Method: "Function",
            Function: "Function",
            Constructor: "Function",
            Field: "Identifier",
            Variable: "Identifier",
            Class: "Structure",
            Interface: "Structure",
            Module: "Function",
            Property: "Identifier",
            Unit: "Identifier",
            Value: "String",
            Enum: "Structure",
            Keyword: "Identifier",
            Snippet: "Structure",
            Color: "Structure",
            File: "Structure",
            Reference: "Function",
            Folder: "Structure",
            EnumMember: "Structure",
            Constant: "String",
            Struct: "Structure",
            Event: "Function",
            Operator: "Identifier",
            TypeParameter: "Identifier",
          },
        },
      },
      postFilters: ["sorter_head"],
    });

    for (
      const filetype of [
        "help",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "gitcommit",
        "comment",
      ]
    ) {
      args.contextBuilder.patchFiletype(filetype, {
        sources: commonSources.concat(["line"]),
      });
    }

    for (const filetype of ["html", "css"]) {
      args.contextBuilder.patchFiletype(filetype, {
        sourceOptions: {
          _: {
            keywordPattern: "[0-9a-zA-Z_:#-]*",
          },
        },
      });
    }

    args.contextBuilder.patchFiletype("ddu-ff-filter", {
      sources: ["line", "buffer"],
      sourceOptions: {
        _: {
          keywordPattern: "[0-9a-zA-Z_:#-]*",
        },
      },
      specialBufferCompletion: true,
    });

    for (
      const filetype of [
        "css",
        "go",
        "graphql",
        "html",
        "lua",
        "python",
        "ruby",
        "tsx",
        "typescript",
        "typescriptreact",
      ]
    ) {
      args.contextBuilder.patchFiletype(filetype, {
        sources: ["lsp"].concat(commonSources),
      });
    }
  }
}
