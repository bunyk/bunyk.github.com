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
        <li><a href="https://github.com/bunyk"><strong>GitHub profile</strong></a></li>
        <li><a href="http://ua.linkedin.com/pub/taras-bunyk/22/487/3a5"><strong>LinkedIn profile</strong></a></li>
        <li><a href="http://stackoverflow.com/users/816449/bunyk"><strong>StackOverflow profile</strong></a></li>
        </ul>
    </dd>

    <dd class="clear"></dd>

    <dt>Professional experience</dt>
    <dd><ul>
        <li><p>(2016 &ndash; 2017) <a href="https://en.wikipedia.org/wiki/ProofPilot">ProofPilot</a>,
            as a junior front-end developer and then front-end team lead.</p>
            <ul>
                <li>Developing two front-ends for clinical trials platform, one for researchers and one for participants: <strong>Technologies:</strong>
                        AngularJS,
                        HTML5,
                        ES6, 
                        Progressive web apps,
                        REST,
                        gulp, 
                        webpack,
                        Docker,
                        Selenium (protractor).
                </li>
                <li>Some of my duties after becoming team lead (in team of two) was working partially as QA and product manager (requirements analysis, writing new requirements for backend).</li>
            </ul>
        </li>
        <li><p>(2013 &ndash; 2015) <a href="http://softserve.ua/">SoftServe</a>,
            as a intermediate Python developer.</p>
            <ul>
                <li>Developing plugins for Zenoss monitoring platform: <strong>Technologies:</strong>
                        Twisted,
                        Zope Component Architecture,
                        Ext.js,
                        SNMP,
                        PowerShell,
                        MySQL,
                        Amazon AWS, boto,
                        CentOS.
                </li>
                <li>Developed front-end for image processing application. <strong>Technologies:</strong>
                        Flask,
                        jQuery,
                        SQLite,
                        Fabric,
                        supervisord,
                        Nginx,
                        Amazon EC2.
                </li>
            </ul>
        </li>
        <li><p>(2011 &ndash; 2012) <a href="http://prom.ua/">Prom.ua</a>,
            as a junior web-developer in CRM team.</p>

            <ul>
                <li><strong>Main duties:</strong>
                        billing,
                        automation of Yandex Direct and Google AdWords,
                        site internal context advertising system,
                        search in client database,
                        emails to certain groups of subscribers,
                        functional testing framework (Mocking data in database and SMTP protocol).
                </li>
                <li><strong>Technologies:</strong>
                        Pylons,
                        SqlAlchemy,
                        PostgreSQL,
                        WTForms,
                        Celery,
                        Yandex Direct API,
                        jQuery,
                        Mercurial.
                </li>
            </ul>
        </li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Hobby experience</dt>
    <dd><p>Before was years of small hacks in different programming languages and technologies. For example:</p>
        <ul>
            <li>I have experience in customizing MediaWiki interface to automate editing (<a href="https://uk.wikipedia.org/wiki/%D0%9A%D0%BE%D1%80%D0%B8%D1%81%D1%82%D1%83%D0%B2%D0%B0%D1%87:Bunyk/%D0%A1%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D0%B8">List of some examples of my code here</a>). From there I have some experience with regular expressions and SPARQL wikidata queries.</li>
            <li>Rendering of n-dimensional cubes. Wireframes in orthogonal projection.
                (<a href="/hypercube/">See online here</a>)</li>
            <li>Rendering of the dodecahedron net with calendar on faces using CSS3 & SVG
                (<a href="/dodecahedron/">See online here</a>)</li>
            <li>3D model of rubics cube. One variant was with GUI on Qt.
                (<a href="http://bunyk.wordpress.com/2009/04/12/cubik/">Blog entry.</a>)</li>
            <li>Scripting Blender to draw some function graphs in 3D.
                Main work was to learn how to create script GUI, and how to
                create and manipulate objects inside Blender.
                (<a href="http://bunyk.wordpress.com/2010/05/05/blender-scripting-2/">Full story</a>)</li>
            <li>Freebase queries. Exploring ontology, collecting information about movies.
                (<a href="http://bunyk.wordpress.com/2011/03/31/hands-on-freebase/">Blog entry</a>)</li>
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
        <li><strong>JavaScript / CoffeeScript</strong> &ndash; jQuery, AngularJS, D3, Vue.JS</li>
        <li><strong>Scala</strong> (In December 2014 finished Functional Programming Principles in Scala with distinction)</li>
        <li><strong>SQL</strong> &ndash; Tried MySQL and SQLite. Actively used PostgreSQL in prom.ua, but very often throught ORM.</li>
        <li><strong>C</strong> (C99) &ndash; learned how to create basic data structures during university programming course. </li>
        <li><strong>C++</strong> &ndash; STL, GLUT, Qt (last two as a wrap around OpenGL) mainly for game development. (<a href="http://bunyk.files.wordpress.com/2010/03/seawar.jpg">screenshot</a>)</li>
        <li><strong>VimScript</strong> &ndash; know how to create custom commands with autocompletion and stuff…</li>
        <li><strong>Common Lisp</strong> &ndash; as a part of AI course.</li>
        <li><strong>C#</strong> &ndash; had written an arcanoid game with XNA. Sources lost. Created translation of introduction to C# 2.0. (<a href="https://bunyk.wordpress.com/2009/02/03/csdnetxna/">link</a>)</li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Languages:</dt>
    <dd><ul>
        <li><strong>English</strong> &ndash; tested as intermediate strong.</li>
        <li><strong>German</strong> &ndash; completed A2 course, enought for surviving in trips.</li>
        <li><strong>Ukrainian</strong> &ndash; native. Intermediate knowledge of grammar and spelling.</li>
        <li><strong>Russian</strong> &ndash; fluent in comprehension, basic in writing and speaking.</li>
    </ul></dd>

    <dd class="clear"></dd>

    <dt>Education</dt>
    <dd>
        <ul>
        <li>(2007-2011) Taras Shevchenko National University of Kyiv, cybernetics faculty, department of theoretical cybernetics. Bachelor of Computer Science.</li>
        </ul>
    </dd>

    <dd class="clear"></dd>


    <dt>Other:</dt>
    <dd><ul>
        </li>
        <li><strong>MOOC:</strong>
            <ul>
                <li>2015 May: <a href="https://www.coursera.org/course/introse">Introduction to Systems Engineering</a> (only listened, no statement of accomplishement)</li>
                <li>2014 December: <a href="https://www.coursera.org/learn/learning-how-to-learn">Learning How to Learn</a> (only listened, no statement of accomplishement)</li>
                <li>2014 December: <a href="https://class.coursera.org/progfun-005">Functional Programming Principles in Scala</a> (<a href="https://bunyk.files.wordpress.com/2014/12/coursera-progfun-2014.pdf">statement of accomplishement with distinction</a>)</li>
            </ul>
        </li>
        <li><strong>Version control:</strong> Git, Mercurial.</li>
        <li><strong>Unix:</strong> Basic knowledge of bash shell.</li>
        <li><strong>Networking:</strong> good knowledge of Ethernet and sockets, basic at other levels of network stack</li>
        <li><strong>OpenGL</strong> &ndash; with Delphi (WinAPI), C++ (GLUT, Qt), Python (Pygame)</li>
        <li><strong>HTML</strong> &ndash; know box model, flexbox, and generally am able to layout stuff.</li>
        <li><img class="latex" title="\LaTeX" alt="\LaTeX" src="http://s0.wp.com/latex.php?latex=%5CLaTeX&amp;bg=ffffff&amp;fg=1c1c1c&amp;s=0"> &ndash; sometimes I blog about math. Sometimes I need to publish my thesis</li>
        <li><strong>MediaWiki</strong> &ndash; deep wikimarkup knowledge, and administration skills.
            I am administrator of Ukrainian wikibooks project.
            (<a href="http://uk.wikibooks.org/wiki/%D0%9A%D0%BE%D1%80%D0%B8%D1%81%D1%82%D1%83%D0%B2%D0%B0%D1%87:Bunyk">uk.wikibooks.org/wiki/Користувач:Bunyk</a>), former administrator of Ukraininan Wikipedia (resigned because conflicts resolution there takes to much time).</li>
    </ul></dd>

    <dt>Relevant events</dt>
    <dd>
        <ul>
            <li>Was participating in <a href="https://www.mediawiki.org/wiki/Wikimedia_Hackathon_2017/Program">Wikimedia hackaton 2017</a></li>
            <li>Was participating in <a href="https://bunyk.wordpress.com/2015/11/18/garage48/">Garage 48</a> hackaton</li>
            <li>Was speaking at LvivPy conference (<a href="https://www.youtube.com/watch?v=e-h8qk13LTw">recording</a>)</li>
        </ul>
    </dd>

    <dd class="clear"></dd>

</dl>

<p class="clear"></p>

<%block name="footer">
<p>${u.present_moment()}. Last version of this document you can find on page <a href="http://bunyk.github.io/resume/">http://bunyk.github.io/resume/</a>.</p>
</%block>

${u.google_analytics()}
