<style>
  a {
    align-items: center;
    color: var(--error);
    display: inline-flex;
    cursor: pointer;
    text-decoration: none;
    padding: 0 10px;
  }
  legend {
    display: inline-block;
    float: right;
    line-height: 20px;
  }
  button {
    box-sizing: border-box;
    cursor: pointer;
    display: inline-block;
    font-family: inherit;
    font-size: inherit;
    margin-top: 7px;
    text-align: center;
  }
  fieldset {
    background-color: var(--white);
    border: 1px solid var(--black);
    display: flex;
    margin: 0 0 -1px 0;
    padding: 0;
  }
  input {
    border: 0;
    border-right: 1px solid var(--black);
    box-sizing: border-box;
    font-family: inherit;
    font-size: inherit;
    padding: 7px;
  }
  input:focus {
    outline: none;
  }
  fieldset input {
    width: calc(65% - 21px);
  }
  fieldset input:first-child {
    width: calc(35% - 1px);
  }
</style>
<script>
  import type { MouseEvent } from '@stackpress/ink/dist/types';
  import StyleSet from '@stackpress/ink/dist/style/StyleSet';
  import setDisplay from '../utilities/style/display';
  import { buttonStyles } from '../utilities/fieldset';
  //extract props
  const { name, add = 'Add', value = {} } = this.props;
  //override default styles
  const styles = new StyleSet();
  const css = this.styles();
  this.styles = () => css + styles.toString();
  //determine display
  setDisplay(this.props, styles, 'block', ':host');
  //determine button styles
  buttonStyles(this.props, styles);
  //set handlers
  const handlers = {
    add: (e: MouseEvent<HTMLButtonElement>) => {
      const shadow = this.shadowRoot;
      if (!shadow) return;
      const button = shadow.querySelector('button');
      if (!button) return;
      const { fieldset, field } = handlers.create(this.childElementCount);
      button.before(fieldset);
      this.appendChild(field);
    },
    create: (index: number, key: string, value?: any) => {
      const input = {
        key: this.createElement('input', { value: key }).element,
        value: this.createElement('input', {value: value }).element
      };
      const field = this.createElement('input', { 
        type: 'hidden',
        name: key ? `${name}[${key}]` : undefined, 
        value 
      }).element;
      const remove = ClientRegistry.createElement(
        'a', {}, [ '&times;' ]
      ).element as HTMLElement;
      const fieldset = ClientRegistry.createElement('fieldset', {}, [
        input.key,
        input.value,
        remove
      ]).element as HTMLElement;
      remove.addEventListener(
        'click', 
        () => handlers.remove(fieldset, field)
      );
      input.key.addEventListener('change', () => {
        const key = input.key.value;
        if (key.trim().length === 0) return;
        field.name = `${name}[${key}]`;
        field.setAttribute('name', `${name}[${key}]`);
      });
      input.value.addEventListener('change', () => {
        field.value = input.value.value;
        field.setAttribute('value', input.value.value);
      });
      return { fieldset, field };
    },
    remove: (fieldset: HTMLElement, field: HTMLElement) => {
      const shadow = this.shadowRoot;
      if (!shadow) return;
      fieldset.remove();
      field.remove();
    }
  };
  //make initial rows
  const rows = Object.entries(value).map(
    ([ key, value ], index) => handlers.create(index, key, value)
  );
</script>
<template type="light">
  {rows.map(row => row.field)}
</template>
<template type="shadow">
  {rows.map(row => row.fieldset)}
  <button type="button" click={handlers.add}>{add}</button>
</template>