<script observe="accept,autocomplete,checked,disabled,max,min,multiple,name,pattern,placeholder,readonly,required,step,type,value">
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
  //override default styles
  const styles = new StyleSet();
  this.styles = () => styles.toString();
  //set default styles
  setDefaultStyles(props, styles);
  //get handlers
  const handlers = getHandlers(this, change, update);
</script>
<template type="light">
  <input {...attributes} change={handlers.change} />
</template>
<template type="shadow">
  <slot></slot>
</template>