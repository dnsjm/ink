<script>
  import ClientRegistry from '@stackpress/ink/dist/client/Registry';
  import StyleSet from '@stackpress/ink/dist/style/StyleSet';
  import Alert from './alert.ink';
  import Icon from './icon.ink';

  //define handlers
  const handlers = {
    //alert maker
    make: (type, message) => {
      //Map:
      //<notif><icon><text><close><progress><bar></progress></notif>
      //create progress & bar
      const bar = ClientRegistry.createElement(
        'div', 
        { 'class': 'bar' }
      ).element;
      const progress = ClientRegistry.createElement(
        'div', 
        { 'class': 'progress' }, 
        [ bar ]
      ).element;
      //create left icon
      const icon = ClientRegistry.createComponent(
        'interface-icon', 
        Icon, 
        { 
          'class': 'icon', 
          none: type === 'primary' 
            || type === 'secondary' 
            || type === 'muted',
          white: true, 
          name: type === 'info' ? 'info-circle' 
            : type === 'warning' ? 'exclamation-triangle'
            : type === 'error' ? 'times-circle'
            : type === 'success' ? 'check-circle'
            : 'info-circle'

        }
      ).element;
      //create right side close icon
      const close = ClientRegistry.createComponent(
        'interface-icon', 
        Icon, 
        { 
          'class': 'close', 
          white: true,
          name: 'times' 
        }
      ).element;
      //create alert notification
      const alert = ClientRegistry.createComponent(
        'interface-alert', 
        Alert,
        { 
          'class': 'alert', 
          warning: type === 'warning',
          error: type === 'error',
          success: type === 'success',
          primary: type === 'primary',
          secondary: type === 'secondary',
          muted: type === 'muted',
          info: type === 'info',

          solid: true,
          curved: true
        }
      ).element;
      //create message container
      const wrapper = ClientRegistry.createElement('div', { 
        'class': 'message'
      }).element;
      wrapper.innerHTML = message;

      alert.appendChild(close);
      alert.appendChild(icon);
      alert.appendChild(wrapper);
      alert.appendChild(progress);

      return { bar, icon, close, progress, alert };
    },
    //notify function api
    notify: (type, message, timeout = 5000) => {
      const { 
        bar, 
        close, 
        progress, 
        alert 
      } = handlers.make(type, message);
      this.shadowRoot?.appendChild(alert);

      const state = { time: 0, progress: 0 };

      const interval = setInterval(() => {
        state.time += smooth;
        state.progress = Math.floor((state.time / timeout) * 100);
        alert.style.opacity = String(
          (timeout - state.time) / timeout
        );
        bar.style.width = `${state.progress}%`;
        if (state.time >= timeout) {
          remove();
        }
      }, smooth);

      const remove = () => {
        this.shadowRoot?.removeChild(alert);
        clearInterval(interval);
      };

      close.addEventListener('click', remove);
    }
  };
  //open notify api
  this.notify = handlers.notify;
  //extract props
  const { 
    //position
    top, left, center,
    //transition
    fade, smooth = 10
  } = this.props;
  //override default styles
  const styles = new StyleSet();
  this.styles = () => styles.toString();
  //host styles
  styles.add(':host', 'position', 'fixed');
  styles.add(':host', 'pointer-events', 'none');
  //determine host position
  top 
    ? styles.add(':host', 'top', '20px') 
    : styles.add(':host', 'bottom', '20px');
  if (left) {
    styles.add(':host', 'left', '20px');
  } else if (center) {
    styles.add(':host', 'left', '0');
    styles.add(':host', 'right', '0');
  } else {
    styles.add(':host', 'right', '20px');
  }
  //alert styles
  styles.add('.alert', 'width', 'calc(100% - 32px)');
  styles.add('.alert', 'position', 'relative');
  styles.add('.alert', 'margin-bottom', '8px');
  styles.add('.alert', 'max-width', '288px');
  styles.add('.alert', 'pointer-events', 'auto');
  if (center) {
    styles.add('.alert', 'margin-left', 'auto');
    styles.add('.alert', 'margin-right', 'auto');
  }
  //close styles
  styles.add('.close', 'display', 'inline-block');
  styles.add('.close', 'float', 'right');
  styles.add('.close', 'color', 'white');
  styles.add('.close', 'cursor', 'pointer');
  styles.add('.close', 'position', 'relative');
  styles.add('.close', 'top', '3px');
  //icon styles
  styles.add('.icon', 'display', 'inline-block');
  styles.add('.icon', 'color', 'white');
  styles.add('.icon', 'margin-right', '5px');
  //progress styles
  styles.add('.progress', 'height', '5px');
  styles.add('.progress', 'width', '100%');
  //bar styles
  styles.add('.bar', 'width', '0%');
  styles.add('.bar', 'height', '100%');
  styles.add('.bar', 'background-color', 'var(--muted)');
  //message styles
  styles.add('.message', 'display', 'inline-block');
</script>