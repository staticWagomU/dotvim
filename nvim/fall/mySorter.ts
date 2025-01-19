import {
  defineSorter,
  Detail,
  type Sorter,
} from "jsr:@vim-fall/std@^0.8.0";


function mtime<T extends Detail>(): Sorter<T> {
  return defineSorter<T>((_denops, { items }) => {
    items.sort((a, b) => {
      try {
        const fileInfoA = Deno.statSync(a.detail.path as string);
        const fileInfoB = Deno.statSync(b.detail.path as string);

        if(fileInfoA.isFile && fileInfoB.isFile) {
          const va = fileInfoA.mtime?.getTime() ?? 0;
          const vb = fileInfoB.mtime?.getTime() ?? 0;
          return vb - va;
        }
        return 0;
      } catch {
        return 0;
      }
    })
  });
}

export { mtime };
