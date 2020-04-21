<meta charset="UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

{% if page.keywords %}
  <meta name="keywords" content="{{ page.keywords }}" />
{% elif page.tags and page.tags.length %}
  <meta name="keywords" content="{% for tag in page.tags %}{{ tag.name }},{% endfor %}" />
{% elif theme.keywords %}
  <meta name="keywords" content="{{ theme.keywords }}" />
{% endif %}

{% if theme.favicon.apple_touch_icon %}
  <link rel="apple-touch-icon" sizes="180x180" href="{{ url_for(theme.favicon.apple_touch_icon) }}?v={{ theme.version }}">
{% endif %}
{% if theme.favicon.narmal %}
  <link rel="icon" type="image/png" sizes="32x32" href="{{ url_for(theme.favicon.narmal) }}?v={{ theme.version }}">
{% endif %}


{# Export some HEXO Configurations to Front-End #}
<script type="text/javascript" id="hexo.configurations">
  var NexT = window.NexT || {};
  var CONFIG = {
    root: '{{ theme.root }}',
    scheme: '{{ theme.scheme }}',
    version: '{{ theme.version }}',
    sidebar: {{ theme.sidebar | json_encode }},
    motion: {{ theme.motion | json_encode }},
    since: '{{ theme.footer.since }}',
    online: JSON.parse('{{ theme.online | json_encode }}'),
    site: {
      title: '{{ theme.title }}',
      subtitle: '{{ theme.subtitle }}',
      author: '{{ theme.author }}'
    },
    favicon: {
      visibilitychange: {{theme.favicon.visibilitychange}},
      narmal: '{{theme.favicon.narmal}}',
      hidden: '{{theme.favicon.hidden}}',
      show_text: '{{theme.favicon.show_text}}',
      hide_text: '{{theme.favicon.hide_text}}'
    }
  };
</script>

<link href="/css/main.css?v={{ theme.version }}" rel="stylesheet" type="text/css" />
