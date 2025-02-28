<style>
  a {
    color: var(--error);
    display: inline-block;
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
    margin: 0 0 -1px 0;
    padding: 0;
  }
  ::slotted(input) {
    border: 0;
    border-right: 1px solid var(--black);
    box-sizing: border-box;
    font-family: inherit;
    font-size: inherit;
    padding: 7px;
    width: calc(100% - 30px);
  }
  ::slotted(input:focus) {
    outline: none;
  }
</style>
<script>
  import type { MouseEvent } from '@stackpress/ink/dist/types';
  import StyleSet from '@stackpress/ink/dist/style/StyleSet';
  import setDisplay from '../utilities/style/display';
  import { buttonStyles } from '../utilities/fieldset';
  //extract props
  const { name, add = 'Add', value = [] } = this.props;
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
    create: (index: number, value?: string) => {
      const field = this.createElement('input', {
        slot: `row-${index}`, name, value
      }).element as HTMLElement;
      const remove = ClientRegistry.createElement(
        'a', {}, [ '&times;' ]
      ).element as HTMLElement;
      const slot = ClientRegistry.createElement(
        'slot', { name: `row-${index}` }
      ).element as HTMLElement;
      const fieldset = ClientRegistry.createElement('fieldset', {}, [
        slot,
        remove
      ]).element as HTMLElement;
      remove.addEventListener('click', () => handlers.remove(fieldset, field));
      return { fieldset, field };
    },
    remove: (fieldset: HTMLElement, slot: HTMLElement) => {
      const shadow = this.shadowRoot;
      if (!shadow) return;
      fieldset.remove();
      slot.remove();
      shadow.querySelectorAll('fieldset slot').forEach((slot, index) => {
        slot.setAttribute('name', `row-${index}`);
      });
      this.querySelectorAll(':scope > [slot]').forEach((slot, index) => {
        slot.setAttribute('slot', `row-${index}`);
      });
    }
  };
  //make initial rows
  const rows = value.map((value, index) => handlers.create(index, value));
</script>
<template type="light">
  {rows.map(row => row.field)}
</template>
<template type="shadow">
  {rows.map(row => row.fieldset)}
  <button type="button" click={handlers.add}>{add}</button>
</template>