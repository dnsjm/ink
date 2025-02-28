<link rel="import" type="component" href="./icon.ink" name="interface-icon" />
<script>
  import StyleSet from '@stackpress/ink/dist/style/StyleSet';
  import setBold from '../utilities/style/bold';
  import setColor from '../utilities/style/color';
  import setCurve from '../utilities/style/curve';
  import setDisplay from '../utilities/style/display';
  import setSize from '../utilities/style/size';
  import setUnderline from '../utilities/style/underline';
  //extract props
  const { 
    //breadcrumbs list
    crumbs = [], 
    //sub-props
    link, sep, icon,
    //default sizes (to pass to icon component)
    size, xs,  sm,  md,  lg, 
    xl,   xl2, xl3, xl4, xl5,
    //default colors (to pass to icon component)
    color,   white, black, info,    warning, 
    success, error, muted, primary, secondary,
    //others
    spacing = 0
  } = this.propsTree;
  //override default styles
  const styles = new StyleSet();
  this.styles = () => styles.toString();
  //determine host display
  const display = setDisplay(this.props, styles, 'block', ':host');
  if (display === 'flex' || display === 'inline-flex') {
    styles.add(':host', 'align-items', 'center');
  }
  //determine host size
  setSize(this.props, styles, false, ':host', 'font-size');
  //determine host color
  setColor(this.props, styles, false, ':host', 'color');
  //default link styles
  styles.add('a', 'cursor', 'pointer');
  if (link) {
    setColor(link, styles, false, 'a', 'color');
  }
  //determine link underline
  setUnderline(this.props, styles, 'a');
  //determine separator spacing
  if (spacing) {
    styles.add('.sep', 'margin', `0 ${spacing}px`);
  }
  //determine selected bold
  setBold(this.props, styles, 'span');
  //pass props from this component to icon component
  const iconProps = icon || {
    //default sizes
    size, xs,  sm,  md,  lg, 
    xl,   xl2, xl3, xl4, xl5,
    //default colors
    color,   white, black, info,    warning, 
    success, error, muted, primary, secondary
  };
  //pass props from this component to icon component
  const sepProps = sep || {
    //default sizes
    size, xs,  sm,  md,  lg, 
    xl,   xl2, xl3, xl4, xl5,
    //default colors
    color,   white, black, info,    warning, 
    success, error, muted, primary, secondary
  };
</script>
<each key=index value=crumb from=crumbs>
  <if true={crumb.icon}>
    <interface-icon {...iconProps} name={crumb.icon} />
  </if>
  <if true={crumb.href && crumb.label}>
    <a href={crumb.href}>{crumb.label}</a>
  <elif true={crumb.label} />
    <span>{crumb.label}</span>
  </if>
  <if true={index < crumbs.length - 1}>
    <interface-icon {...sepProps} name="chevron-right" class="sep" />
  </if>
</each>