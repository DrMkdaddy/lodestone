// This file was generated by [ts-rs](https://github.com/Aleph-Alpha/ts-rs). Do not edit this file manually.
import type { FileType } from './FileType';

export interface File {
  name: string;
  path: string;
  creation_time: number | null;
  modification_time: number | null;
  file_type: FileType;
}
