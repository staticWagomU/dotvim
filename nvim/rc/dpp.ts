import { ensure, is } from "https://deno.land/x/unknownutil@v3.16.3/mod.ts";
import {
  BaseConfig,
  ConfigReturn,
  ContextBuilder,
  Dpp,
  Plugin,
} from "https://deno.land/x/dpp_vim@v0.0.5/types.ts";
import { Denops } from "https://deno.land/x/dpp_vim@v0.0.5/deps.ts";

type Toml = {
  ftplugins?: Record<string, string>;
  plugins?: Plugin[];
};

type LazyMakeStateResult = {
  plugins: Plugin[];
  stateLines: string[];
};

const isStringArray = is.ArrayOf(is.String);
// https://github.com/kuuote/dotvim/blob/version5/conf/dpp.ts?plain=1#L27-L32
async function glob(denops: Denops, path: string): Promise<string[]> {
  return ensure(
    await denops.call("glob", path, 1, 1),
    isStringArray,
  );
}

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    const dotfilesDir = "~/dotvim/nvim/rc";
    const tomlPaths = await glob(args.denops, "~/dotvim/nvim/lua/plugins/*.lua");

    args.contextBuilder.setGlobal({
      extParams: {
        installer: {
          checkDiff: true,
          logFilePath: "~/.cache/dpp/installer-log.txt",
        },
      },
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);

    const tomls: Toml[] = [];
    for (const tomlPath of tomlPaths) {
      const toml = await args.dpp.extAction(
        args.denops,
        context,
        options,
        "lua",
        "load",
        {
          path: tomlPath,
          options: {
            lazy: false,
          },
        },
      ) as Toml | undefined;

      if (toml) {
        tomls.push(toml);
      }
    }
    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};

    tomls.forEach((toml) => {
      for (const plugin of toml.plugins!) {
        recordPlugins[plugin.name] = plugin;
      }

      if (toml.ftplugins) {
        for (const filetype of Object.keys(toml.ftplugins)) {
          if (ftplugins[filetype]) {
            ftplugins[filetype] += `\n${toml.ftplugins[filetype]}`;
          } else {
            ftplugins[filetype] = toml.ftplugins[filetype];
          }
        }
      }
    });

    const localPlugins = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "local",
      "local",
      {
        directory: "~/dotvim/nvim/plug",
        options: {
          frozen: true,
          merged: false,
        },
        includes: [
          "ddu-source-keymaps",
          "denops-statusline",
        ],
      },
    ) as Plugin[] | undefined;

    if (localPlugins) {
      for (const plugin of localPlugins) {
        if (plugin.name in recordPlugins) {
          recordPlugins[plugin.name] = Object.assign(
            recordPlugins[plugin.name],
            plugin,
          );
        } else {
          recordPlugins[plugin.name] = plugin;
        }
      }
    }

    const lazyResult = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins: Object.values(recordPlugins),
      },
    ) as LazyMakeStateResult | undefined;

    const checkFiles = [
      await glob(args.denops, `${dotfilesDir}/*.lua`),
      await glob(args.denops, `${dotfilesDir}/*.ts`),
    ].flat();

    return {
      checkFiles: checkFiles,
      ftplugins: ftplugins,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
