import { ensure, is } from "jsr:@core/unknownutil@~4.3.0";
import { ContextBuilder, Plugin } from "jsr:@shougo/dpp-vim@~4.1.0/types";
import {
  BaseConfig,
  type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~4.1.0/config";
import { Dpp } from "jsr:@shougo/dpp-vim@~4.1.0/dpp";
import { Denops } from "jsr:@denops/core@~7.0.1";

type Toml = {
  plugins: Plugin[];
};

const isStringArray = is.ArrayOf(is.String);
//https://github.com/kuuote/dotvim/blob/cce964b162abfe0e74c4932d74697c4b01caf146/conf/dpp.ts?plain=1#L27-L32
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
    const config_base = await args.denops.call("stdpath", "config");

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

    const plugins: Plugin[] = [];

    const tomls = await glob(args.denops, `${config_base}/plugins/*.toml`);
    for (const tomlPath of tomls) {
      console.log(tomlPath);
      const toml = await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        {
          path: tomlPath,
        },
      ) as {
        plugins: Plugin[];
      };

      plugins.push(...toml.plugins);
    }

    const lazyTomls = await glob(
      args.denops,
      `${config_base}/plugins/lazy/*.toml`,
    );
    for (const tomlPath of lazyTomls) {
      const toml = await args.dpp.extAction(
        args.denops,
        context,
        options,
        "toml",
        "load",
        {
          path: tomlPath,
          options: {
            lazy: true,
          },
        },
      ) as Toml;

      plugins.push(...toml.plugins);
    }

    const result = await args.dpp.extAction(
      args.denops,
      context,
      options,
      "lazy",
      "makeState",
      {
        plugins,
      },
    ) as {
      plugins: Plugin[];
    };

    return {
      plugins: result.plugins,
    };
  }
}
