<%inherit file="../base.mako" />
<%namespace name="u" file="../utils.mako"/>

<%block name="head">
	<link rel="stylesheet" href="../styles/matrix.css" />
	<link rel="stylesheet" href="../styles/global_layout.css" />
	<link rel="stylesheet" href="layout.css" />
    ${u.requirejs('main.coffee')}
</%block>

<%block name="title">HTML5 SVG graphics test</%block>

<p>Все просто, головне - взяти <a href="http://uk.wikipedia.org/wiki/%D0%9C%D0%B0%D1%82%D1%80%D0%B8%D1%86%D1%8F_%D0%BF%D0%BE%D0%B2%D0%BE%D1%80%D0%BE%D1%82%D1%83">матрицю повороту</a> розміру &times n, а не 3 &times; 3 як то буває в 3d графіці.</p>
<div class="widget_block">
<div id="surface">
    <div id="panel">
        <img src="../icons/reload-32px.png" width="32" height="32" id="reset"/>
        <span id="play_pause">
            <img src="../icons/play-32px.png" width="32" height="32" class="play"/>
            <img src="../icons/pause-32px.png" width="32" height="32" class="pause"/>
        </span>
    </div>
</div>
<div id="matrix"></div>
</div>
<h2 id="todo">TODO:</h2>
<ul>
    <li>Додати контролери зручного редагування матриці повороту: зміни її розмірностей, вибору площин повертання, ручного повороту, та й взагалі, ручного редагування, це ж не обов’язково тільки матриця повороту. :)</li>
    <li>Заюзати якийсь фреймворк для класів та MVC.</li>
    <li>Більше модульного тестування!</li>
    <li>Придумати якусь топологію окрім кубика... <a href="http://bunyk.wordpress.com/2009/04/27/n-dimensional-cube/">Кубик я вже дуже давно придумав...</a></li>
</ul>

<h2>Використані технології:</h2>
<ul>
    <li>Вбудовуваний в HTML5 SVG для промальовування.</li>
    <li><code>requirejs.py</code> для модульності і топологічного сортування залежностей. Власний велосипед.</li>
    <li>jQuery для зміни DOM.</li>
    <li>radio.js для реалізації події переміщення точки.</li>
    <li>QUnit для невеличкого модульного тестування.</li>
</ul>

${u.disqus_thread('hypercube')}
