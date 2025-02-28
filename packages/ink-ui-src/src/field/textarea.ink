<script observe="disabled,name,placeholder,readonly,required,rows">
  import StyleSet from '@stackpress/ink/dist/style/StyleSet';
  import { 
    getProps, 
    getHandlers,
    setDefaultStyles
  } from '../utilities/input';
  //extract props
  const { 
    //handlers
    change, update,
    //input attributes
    attributes, 
    //the rest of the props
    ...props
  } = getProps(this);
  //set the host classes
  const children = this.originalChildren;
  //override default styles
  const styles = new StyleSet();
  this.styles = () => styles.toString();
  //set default styles
  setDefaultStyles(props, styles);
  //get handlers
  const handlers = getHandlers(this, change, update);
</script>
<template type="light">
  <textarea {...attributes} change={handlers.change}>{children}</textarea>
</template>
<template type="shadow">
  <slot></slot>
</template>