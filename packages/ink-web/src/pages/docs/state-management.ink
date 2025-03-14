<link rel="import" type="template" href="@/components/html/head" name="html-head" />
<link rel="import" type="template" href="@/components/html/header" name="html-header" />
<link rel="import" type="template" href="@/components/html/aside" name="html-aside" />
<link rel="import" type="component" href="@stackpress/ink-ui/layout/panel" name="panel-layout" />
<link rel="import" type="component" href="@stackpress/ink-ui/element/alert" name="element-alert" />
<link rel="import" type="component" href="@stackpress/ink-ui/element/icon" name="element-icon" />
<link rel="import" type="component" href="@/components/api/docs" name="api-docs" />
<link rel="import" type="component" href="@/components/api/ui" name="api-ui" />
<link rel="import" type="component" href="@/components/ide/app" name="ide-app" />
<link rel="import" type="component" href="@/components/ide/code" name="ide-code" />
<link rel="import" type="component" href="@/components/i18n/translate" name="i18n-translate" />
<style>
  @ink theme;
  @ink reset;
  @ink fouc-opacity;
  @ink utilities;
  .col-2 {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }
</style>
<script>
  import { env } from '@stackpress/ink';
  import { _ } from '@/components/i18n';

  const url = '/docs/state-management.html';
  const title = _('State Management - Ink reactive web component template engine.');
  const description = _('Learn how to manage states in Ink.');
  const toggle = () => {
    document.getElementsByTagName('panel-layout')[0].toggle('left');
  };
</script>
<html>
  <html-head />
  <body class="light bg-t-0 tx-t-1 tx-arial">
    <panel-layout>
      <header><html-header /></header>
      <aside left><html-aside /></aside>
      <aside right>
        <menu class="m-0 px-10 py-20 h-calc-full-40 bg-t-2 scroll-auto">
          <h6 class="tx-muted tx-14 mb-0 mt-0 pb-10 tx-upper">
            {_('On this page')}
          </h6>
          <nav class="tx-14 tx-lh-32">
            <a class="block tx-t-0" href="#props">{_('Props')}</a>
            <a class="block tx-t-0" href="#signals">{_('Signals')}</a>
            <a class="block tx-t-0" href="#events">{_('Events')}</a>
            <a class="block tx-t-0" href="#classnames">{_('Class Names')}</a>
            <a class="block tx-t-0" href="#children">{_('Children')}</a>
            <a class="block tx-t-0" href="#component">{_('Component')}</a>
            <a class="block tx-t-0" href="#env">{_('Env Variables')}</a>
            <a class="block tx-t-0" href="#this">{_('this')}</a>
          </nav>
        </menu>
      </aside>
      <main>
        <api-docs>
          <h1 class="tx-primary tx-upper tx-30 py-20">
            {_('State Management')}
          </h1>
          <i18n-translate p trim class="tx-lh-36 py-20">
            Ink provides several ways to manage properties and states 
            in your components.
          </i18n-translate>

          <a name="props"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Props')}
          </h2>

          <ide-code lang="js" trim detab={12}>{`
            import { props } from '@stackpress/ink';
            const { title, description } = props();
          `}</ide-code>

          <i18n-translate p trim class="tx-lh-36 py-20">
            The <code>props</code> function can be used to access the 
            properties of a component.
          </i18n-translate>

          <a name="signals"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Signals')}
          </h2>

          <i18n-translate p trim class="tx-lh-36 py-20">
            Ink provides a reactive state management system that allows 
            you to manage states in your components. The system is based 
            on signals, which are reactive variables that can be used to 
            store and update data. Signals can be used to store any type 
            of data, including numbers, strings, objects, arrays, and even 
            functions.
          </i18n-translate>

          <div class="scroll-auto bg-black">
            <ide-code trim detab={14}>{`
              <script>
                import { signal } from '@stackpress/ink';
                const count = signal<number>(1);
              </script>
              <em class=classlist>Count #{count.value}</em>
            `}</ide-code>
          </div>

          <i18n-translate p trim class="tx-lh-36 py-20">
            To create a signal, you can use the 
            <ide-code type="javascript" inline>{`signal()`}</ide-code> 
            function, which takes an initial value as an argument. Signals 
            can be read and updated using the <code>value</code> property. 
            Setting the value will trigger a re-render of the component.
          </i18n-translate>

          <i18n-translate p trim class="tx-lh-36 py-20">
            Signals can be used in your components to manage states and 
            trigger updates when the state changes. You can use signals to 
            store data that needs to be shared between components, or to 
            trigger side effects when the state changes. Signals can also 
            be used to store data that needs to be persisted across page 
            reloads, such as form data or user preferences.
          </i18n-translate>

          <a name="events"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Events')}
          </h2>

          <div class="scroll-auto bg-black">
            <ide-code trim number detab={14}>{`
              <script>
                import { signal } from '@stackpress/ink';
                const count = signal<number>(1);
                const add = e => count.value++;
              </script>

              <button click=add>{count.value}</button>

              <button dblclick=add>{count.value}</button>
              <button mousedown=add>{count.value}</button>
              <button mouseup=add>{count.value}</button>
              <button mousemove=add>{count.value}</button>
              <button mouseover=add>{count.value}</button>
              <button mouseout=add>{count.value}</button>
              <button wheel=add>{count.value}</button>
              <button keydown=add>{count.value}</button>
              <button keypress=add>{count.value}</button>
              <button keyup=add>{count.value}</button>
            `}</ide-code>
          </div>

          <i18n-translate p trim class="tx-lh-36 py-20">
            For example, you can use the <ide-code inline>click</ide-code> 
            attribute assigned to a function to trigger a function when 
            the element is clicked. In combination with updating a signal, 
            can trigger a re-render of the component. The following event 
            attributes are supported.
          </i18n-translate>

          <div class="col-2">
            <div>
              <h3>{_('Mouse Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>click</ide-code></li>
                <li><ide-code inline>dblclick</ide-code></li>
                <li><ide-code inline>mousedown</ide-code></li>
                <li><ide-code inline>mouseup</ide-code></li>
                <li><ide-code inline>mousemove</ide-code></li>
                <li><ide-code inline>mouseover</ide-code></li>
                <li><ide-code inline>mouseout</ide-code></li>
                <li><ide-code inline>wheel</ide-code></li>
              </ul>
              <h3>{_('Keyboard Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>keydown</ide-code></li>
                <li><ide-code inline>keypress</ide-code></li>
                <li><ide-code inline>keyup</ide-code></li>
              </ul>
              <h3>{_('Form Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>blur</ide-code></li>
                <li><ide-code inline>change</ide-code></li>
                <li><ide-code inline>contextmenu</ide-code></li>
                <li><ide-code inline>focus</ide-code></li>
                <li><ide-code inline>input</ide-code></li>
                <li><ide-code inline>submit</ide-code></li>
                <li><ide-code inline>invalid</ide-code></li>
                <li><ide-code inline>reset</ide-code></li>
                <li><ide-code inline>search</ide-code></li>
                <li><ide-code inline>select</ide-code></li>
              </ul>
              <h3>{_('Clipboard Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>copy</ide-code></li>
                <li><ide-code inline>cut</ide-code></li>
                <li><ide-code inline>paste</ide-code></li>
              </ul>
              <h3>{_('Transition Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>transitionend</ide-code></li>
              </ul>
            </div>
            <div>
              <h3>{_('Drag Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>drag</ide-code></li>
                <li><ide-code inline>dragstart</ide-code></li>
                <li><ide-code inline>dragend</ide-code></li>
                <li><ide-code inline>dragover</ide-code></li>
                <li><ide-code inline>dragenter</ide-code></li>
                <li><ide-code inline>dragleave</ide-code></li>
                <li><ide-code inline>drop</ide-code></li>
                <li><ide-code inline>scroll</ide-code></li>
              </ul>
              <h3>{_('Media Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>durationchange</ide-code></li>
                <li><ide-code inline>ended</ide-code></li>
                <li><ide-code inline>error</ide-code></li>
                <li><ide-code inline>loadeddata</ide-code></li>
                <li><ide-code inline>loadedmetadata</ide-code></li>
                <li><ide-code inline>loadstart</ide-code></li>
                <li><ide-code inline>pause</ide-code></li>
                <li><ide-code inline>play</ide-code></li>
                <li><ide-code inline>playing</ide-code></li>
                <li><ide-code inline>progress</ide-code></li>
                <li><ide-code inline>ratechange</ide-code></li>
                <li><ide-code inline>seeked</ide-code></li>
                <li><ide-code inline>seeking</ide-code></li>
                <li><ide-code inline>stalled</ide-code></li>
                <li><ide-code inline>suspend</ide-code></li>
                <li><ide-code inline>timeupdate</ide-code></li>
                <li><ide-code inline>volumechange</ide-code></li>
                <li><ide-code inline>waiting</ide-code></li>
              </ul>
              <h3>{_('Animation Events')}</h3>
              <ul class="tx-lh-36">
                <li><ide-code inline>animationstart</ide-code></li>
                <li><ide-code inline>animationend</ide-code></li>
                <li><ide-code inline>animationiteration</ide-code></li>
              </ul>
            </div>
          </div>

          <a name="classnames"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Class Names')}
          </h2>

          <div class="scroll-auto bg-black">
            <ide-code lang="js" trim detab={14}>{`
              import { classnames } from '@stackpress/ink';
              const classlist = classnames(); //--> 'class1 class2 class3'
            `}</ide-code>
          </div>

          <i18n-translate p trim class="tx-lh-36 py-20">
            The <code>classnames</code> function can be used to generate 
            a list of class names based on the properties of an object.
          </i18n-translate>

          <a name="children"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Children')}
          </h2>

          <div class="scroll-auto bg-black">
            <ide-code lang="js" trim detab={14}>{`
              import { children } from '@stackpress/ink';
              const childlist = children(); //--> Node[]
            `}</ide-code>
          </div>
          <i18n-translate p trim class="tx-lh-36 py-20">
            The <code>children</code> function can be used to render 
            child components in a parent component.
          </i18n-translate>

          <a name="component"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Component')}
          </h2>

          <div class="scroll-auto bg-black">
            <ide-code lang="js" trim detab={14}>{`
              import { component } from '@stackpress/ink';
              const button = component(); //--> HTMLElement
              console.log(button.querySelector('span'));
            `}</ide-code>
          </div>
          <i18n-translate p trim class="tx-lh-36 py-20">
            For other edge cases, the <code>component</code> function 
            can be used to get raw access to the component's 
            functionality.
          </i18n-translate>

          <a name="env"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('Environment Variables')}
          </h2>

          <ide-code trim detab={12}>{`
            <script>
              import { env } from '@stackpress/ink';
              const { BUILD_ID, NODE_ENV } = env();
            </script>
            <if true={NODE_ENV === 'development'}>
              <p>Development mode</p>
            </if>
          `}</ide-code>
          <i18n-translate p trim class="tx-lh-36 py-20">
            The <code>env</code> function can be used to access environment 
            variables in a component.
          </i18n-translate>

          <a name="this"></a>
          <h2 class="tx-primary tx-upper tx-26 pt-40 pb-10 mb-20 b-solid b-t-1 bb-1 bt-0 bx-0">
            {_('this')}
          </h2>

          <ide-app title="What's this" class="py-20">
            <ide-code numbers detab={14}>{`
              <script>
                this.props;
                this.style;
                this.classList;
                this.parentNode;
                this.innerHTML;
                this.appendChild();
                this.querySelector('p');
              </script>
            `}</ide-code>
          </ide-app>

          <i18n-translate p trim class="tx-lh-36 py-20">
            <ide-code inline>this</ide-code> refers to the 
            <ide-code inline>InkComponent</ide-code> that extends 
            <ide-code inline>HTMLElement</ide-code>. This means all
            components in Ink are in fact are HTML elements and has
            access to the common functionality like 
            <ide-code inline>innerHTML</ide-code> and
            <ide-code inline>{`querySelector()`}</ide-code> to name a 
            few. <ide-code inline>InkComponent</ide-code> has the
            additional following properties and methods that you can access
            using <ide-code inline>this</ide-code>.
          </i18n-translate>

          <api-ui start="InkComponent" />

          <element-alert curved info class="py-20 tx-lh-24">
            <element-icon name="info-circle" />
            <strong>Info:</strong> You can discover more methods and properties
            of the <code>HTMLElement</code> class on the
            <a 
              target="_blank"
              class="tx-white tx-underline"
              href="https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement"
            >
              MDN Web Docs
            </a>.
          </element-alert>

          <nav class="flex">
            <a class="tx-primary py-40" href="/ink/docs/markup-syntax.html">
              <element-icon name="chevron-left" theme="tx-1" />
              {_('Markup Syntax')}
            </a>
            <a class="flex-grow tx-right tx-primary py-40" href="/ink/docs/component-strategy.html">
              {_('Component Strategy')}
              <element-icon name="chevron-right" theme="tx-1" />
            </a>
          </nav>
          <footer class="foot"></footer>
        </api-docs>
      </main>
    </panel-layout>
  </body>
</html>