//stackpress
import type { FileSystem } from '@stackpress/lib/dist/types';
import type { MediaSize } from '@stackpress/ink/dist/types';
import type StyleMap from '@stackpress/ink/dist/style/StyleMap';
import type StyleSheet from '@stackpress/ink/dist/style/StyleSheet';

export type LiteralToken = {
  type: 'literal',
  classname: string,
  styles: StyleMap,
  media: MediaSize,
  selector: string
};

export type ExpressionToken = {
  type: 'expression',
  pattern: string,
  styles: StyleMap,
  step: number[],
  media: MediaSize,
  pseudo?: string
};

export type RangeToken = {
  name: string,
  property: string,
  directional: boolean,
  calculable: boolean,
  negatable: boolean,
  measurable: boolean
};

export type Token = LiteralToken|RangeToken|ExpressionToken;

export type Plugin = (sheet: string, brand: string) => string;
export type Styler = (
  classnames: string[], 
  stylesheet: StyleSheet,
  cache: Set<string>
) => void;

export type ParserOptions = { fs?: FileSystem, cwd?: string };
export type UtilityPluginOptions =  { 
  stylers?: Styler[],
  files?: string[]
  contents?: Record<string, string>
};
export type ComponentPluginOptions = {
  stylers?: Styler[]
};

export type InkCSSOptions = {
  brand?: string
};