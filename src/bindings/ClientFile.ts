// This file was generated by [ts-rs](https://github.com/Aleph-Alpha/ts-rs). Do not edit this file manually.
import type { FileType } from './FileType';

export interface ClientFile {
  name: string;
  file_stem: string;
  extension: string | null;
  path: string;
  size: number | null;
  creation_time: number | null;
  modification_time: number | null;
  file_type: FileType;
}
