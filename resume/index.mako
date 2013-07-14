<%inherit file="../base.mako"/>
<%namespace name="u" file="../utils.mako"/>
<%block name="head">
	<link rel="stylesheet" href="style.css" />
</%block>

<%block name="title">Taras Bunyk</%block>

<p>1990 birth, Ukraine. Male.  Bachelors degree in computer science.</p>
<dl>
    <dt>Contacts</dt>
    <dd>
        <ul>
        <li><strong>Email</strong>: <a href="mailto:tbunyk@gmail.com">tbunyk@gmail.com</a></li>
        <li><strong>Phone</strong>: +380973162190</li>
        <li><strong>Skype</strong>: tbunyk</li>
        <li><strong>Address</strong>: Lviv</li>
        <li><a href="http://bunyk.wordpress.com/"><strong>Personal blog</strong></a></li>
        <li><a href="http://code.google.com/u/tbunyk/"><strong>Google code profile</strong></a> (my code samples)</li>
        <li><a href="https://github.com/bunyk"><strong>GitHub profile</strong></a> (a little more code samples)</li>
        <li><a href="http://ua.linkedin.com/pub/taras-bunyk/22/487/3a5"><img border="0" height="15" width="80" alt="View Taras Bunyk's profile on LinkedIn" src="http://www.linkedin.com/img/webpromo/btn_profile_bluetxt_80x15.png" style="vertical-align:middle;"></a></li>
        </ul>
    </dd>

    <dd class="clear"></dd>

    <dt>Education</dt>
    <dd>
        <ul>
        <li>(2007-2011) Taras Shevchenko National University of Kyiv, cybernetics faculty, department of theoretical cybernetics. Bachelor of Computer Science.</li>
        <li>(2004-2007) Physical and Technical lyceum of Ivano-Frankivsk National Technical University of Oil and Gas.</li>
        </ul>
    </dd>

    <dd class="clear"></dd>

    <dt>Work experience</dt>
    <dd><ul>
        <li><p>(2013 &ndash; till now) <a href="http://softserve.ua/">SoftServe</a>,
            as a intermediate web-developer.</p>
            <ul>
                <li><strong>Technologies:</strong>
                    <ul>
                        <li>Leaflet</li>
                        <li>Flask</li>
                    </ul>
                </li>
            </ul>
        </li>
        <li><p>(2011 &ndash; 2012) <a href="http://prom.ua/">Prom.ua</a>,
            as a <strong>junior web-developer</strong> in CRM team.</p>

            <ul>
                <li><strong>Main duties:</strong>
                    <ul>
                        <li>Billing,</li>
                        <li>automation of Yandex Direct and Google AdWords,</li>
                        <li>site internal context advertising system,</li>
                        <li>search in client database,</li>
                        <li>emails to certain groups of subscribers,</li>
                        <li>functional testing framework (Mocking data in database and SMTP protocol).</li>
                    </ul>
                </li>
                <li><strong>Technologies:</strong>
                    <ul>
                        <li>Pylons,</li>
                        <li>SqlAlchemy,</li>
                        <li>PostgreSQL,</li>
                        <li>WTForms,</li>
                        <li>Celery,</li>
                        <li>Yandex Direct API,</li>
                        <li>jQuery</li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Home experience</dt>
    <dd><p>Before was years of small hacks in different programming languages and technologies. For example:</p>
        <ul>
            <li>Scripting Blender to draw some function graphs in 3D.
                Main work was to learn how to create script GUI, and how to
                create and manipulate objects inside Blender.
                (<a href="http://bunyk.wordpress.com/2010/05/05/blender-scripting-2/">Full story</a>)</li>
            <li>Freebase queries. Exploring ontology, collecting information about movies.
                (<a href="http://bunyk.wordpress.com/2011/03/31/hands-on-freebase/">Blog entry</a>)</li>
            <li>3D model of rubics cube. One variant was with GUI on Qt.
                (<a href="http://bunyk.wordpress.com/2009/04/12/cubik/">Blog entry.</a>)</li>
            <li>Rendering of n-dimensional cubes. Wireframes in orthogonal projection.
                (<a href="/hypercube/">See online here</a>)</li>
            <li>Grabbing well-formated content from Mediawiki sites to wordpress.
                (<a href="http://bunyk.wordpress.com/2011/02/11/wiki-to-wordpress/">Blog entry.</a>)
            </li>
            <li>And many more, not so interesting…</li>
        </ul>
    </dd>

    <dd class="clear"></dd>

    <dt>Programming languages:</dt>
    <dd><ul>
        <li><strong>Python</strong> &ndash; for a lot of small hacks, some game development, and clients for some web-services (bwikibot). Also main working language at prom.ua. Even know what metaclasses is (and can write some), but still can’t remember descriptor protocol (but know that such thing exists).</li>
        <li><strong>JavaScript / CoffeeScript</strong> &ndash; jQuery.</li>
        <li><strong>SQL</strong> &ndash; Tried MySQL and SQLite. Actively used PostgreSQL in prom.ua, but very often throught ORM.</li>
        <li><strong>C</strong> (C99) &ndash; learned how to create basic data structures during university programming course. </li>
        <li><strong>C++</strong> &ndash; STL, GLUT, Qt (last two as a wrap around OpenGL) mainly for game development. (<a href="http://bunyk.files.wordpress.com/2010/03/seawar.jpg">screenshot</a>)</li>
        <li><strong>VimScript</strong> &ndash; know how to create custom commands with autocompletion and stuff…</li>
        <li><strong>Common Lisp</strong> &ndash; as a part of AI course.</li>
        <li><strong>C#</strong> &ndash; had written an arcanoid game with XNA. Sources lost. Created translation of introduction to C# 2.0. (<a href="https://bunyk.wordpress.com/2009/02/03/csdnetxna/">link</a>)</li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Technologies:</dt>
    <dd><ul>
        <li><strong>OpenGL</strong> &ndash; with Delphi (WinAPI), C++ (GLUT, Qt), Python (Pygame)</li>
        <li><strong>XML</strong> &ndash; DOM, SAX, XPath</li>
        <li><strong>HTML</strong> &ndash; able to create this CV, and other not so bad pages.</li>
        <li><img class="latex" title="\LaTeX" alt="\LaTeX" src="http://s0.wp.com/latex.php?latex=%5CLaTeX&amp;bg=ffffff&amp;fg=1c1c1c&amp;s=0"> &ndash; sometimes I blog about math. Sometimes I need to publish my thesis</li>
        <li><strong>MediaWiki</strong> &ndash; deep wikimarkup knowledge, and administration skills.
            I am administrator of Ukrainian wikibooks project.
            (<a href="http://uk.wikibooks.org/wiki/%D0%9A%D0%BE%D1%80%D0%B8%D1%81%D1%82%D1%83%D0%B2%D0%B0%D1%87:Bunyk">uk.wikibooks.org/wiki/Користувач:Bunyk</a>)</li>
        <li><strong>Mercurial</strong>. Able to fix my own wrong merges. :)</li>
        <li><strong>Unix shell</strong>. Basic knowledge of common filters and piping.
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Languages:</dt>
    <dd><ul>
        <li><strong>English</strong> &ndash; fluent in reading, intermediate in listening, basic in writing, almost not tested in speaking.</li>
        <li><strong>Ukrainian</strong> &ndash; native. Intermediate knowledge of grammar and spelling.</li>
        <li><strong>Russian</strong> &ndash; fluent in comprehension, basic in writing and speaking.</li>
        <li><strong>Esperanto</strong> &ndash; basic level. Need more motivation to learn it.</li>
        <li><strong>German</strong> &ndash; able to read Rapunzel, working on it in free time.</li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Other:</dt>
    <dd><ul>
        <li><strong>Experienced editor</strong> &ndash; passionate wikipedian and blogger, Vim user.</li>
        <li><strong>High English to Ukrainian translation skills</strong> &ndash; not so bad even in fiction translation. (<a href="http://bunyk.wordpress.com/2011/04/28/martin-eden/">My favourite part from Martin Eden.</a>)</li>
    </ul></dd>
</dl>

<p class="clear"></p>

<%block name="footer">
<p>${u.present_moment()}. Last version of this document you can find on page <a href="http://bunyk.github.io/resume/">http://bunyk.github.io/resume/</a>.</p>
</%block>

${u.google_analytics()}

