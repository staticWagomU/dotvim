import { Denops } from "https://deno.land/x/denops_std@v6.0.0/mod.ts";
import * as op from "https://deno.land/x/denops_std@v6.0.0/option/mod.ts";

export function main(denops: Denops): void {
  denops.dispatcher = {
    async init() {
      await op.statusline.set(denops, "Denopstatusline ");
    },
  };
}
