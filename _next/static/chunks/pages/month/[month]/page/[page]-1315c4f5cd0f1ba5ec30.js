(self.webpackChunk_N_E=self.webpackChunk_N_E||[]).push([[235],{4698:function(e,n,t){"use strict";t.d(n,{Z:function(){return m}});var r=t(5893),s=t(5834),i=t(3832),a=t(1749),c=t(9008),o=t(1664),l=t(8358),u=t(2318),d=t(1120),h="Taras Bunyk",p=[{url:"/",title:"Home"},{url:"/resume",title:"Resume"},{url:"https://bunyk.wordpress.com/",title:"Old blog (in Ukrainian)"}],f=(0,d.Z)((function(e){return{toolbar:{borderBottom:"1px solid ".concat(e.palette.divider)},toolbarTitle:{flex:1},toolbarSecondary:{justifyContent:"space-between",overflowX:"auto"},toolbarLink:{padding:e.spacing(1),flexShrink:0}}}));function x(e){var n=e.title,t=f();return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(c.default,{children:(0,r.jsx)("title",{children:n})}),(0,r.jsx)(l.Z,{className:t.toolbar,children:(0,r.jsx)(u.Z,{component:"h1",variant:"h5",aligh:"center",className:t.toolbarTitle,noWrap:!0,children:h})}),(0,r.jsx)(l.Z,{component:"nav",variant:"dense",className:t.toolbarSecondary,children:p.map((function(e){return(0,r.jsx)(o.default,{href:e.url,className:t.toolbarLink,passHref:!0,children:e.title},e.url)}))})]})}function j(){return(0,r.jsxs)(u.Z,{variant:"body2",color:"textSecondary",align:"center",children:["\xa9 ",(new Date).getFullYear()," Bunyk Taras. Built with Material UI & Next.js"]})}function m(e){var n=e.children,t=e.title;return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(s.ZP,{}),(0,r.jsxs)(i.Z,{maxWidth:"md",children:[(0,r.jsx)(x,{title:t||h}),(0,r.jsxs)(a.Z,{container:!0,spacing:5,children:[n,(0,r.jsx)(j,{})]})]})]})}},8102:function(e,n,t){"use strict";t.d(n,{Z:function(){return m}});var r=t(5893),s=t(1749),i=t(4933),a=t(4697),c=t(9912),o=t(1907),l=t(1120),u=t(1664),d=t(3530);function h(e){var n=e.href,t=e.children;return e.disabled?(0,r.jsx)(d.Z,{disabled:!0,children:t}):(0,r.jsx)(u.default,{href:n,passHref:!0,children:(0,r.jsx)(d.Z,{component:"a",children:t})})}function p(e){for(var n=e.page,t=e.count,s=e.pageURL,i=[],a=1;a<=t;a++)i.push((0,r.jsx)(h,{href:s(a),disabled:a==n,children:a},a));return(0,r.jsx)(r.Fragment,{children:i})}var f=t(4698),x=t(7940),j=(0,l.Z)((function(e){return{spaced:{margin:e.spacing(1)}}}));function m(e){var n=j();return(0,r.jsxs)(f.Z,{children:[(0,r.jsxs)(s.Z,{item:!0,xs:12,md:9,children:[e.posts.map((function(e){return(0,r.jsxs)(i.Z,{className:n.spaced,children:[(0,r.jsx)(a.Z,{title:e.title,subheader:"Published: "+e.date+" Tags: "+(e.tags||[]).join(", ")}),(0,r.jsx)(c.Z,{dangerouslySetInnerHTML:{__html:e.excerpt}}),(0,r.jsx)(o.Z,{children:(0,r.jsx)(h,{href:"/posts/".concat(e.id),children:"More"})})]},e.id)})),(0,r.jsx)(p,{count:e.pagesCount,page:e.pageNumber,pageURL:e.pageURL})]}),(0,r.jsx)(x.Z,{archives:e.archives,topics:e.topics})]})}},7940:function(e,n,t){"use strict";t.d(n,{Z:function(){return o}});var r=t(5893),s=t(1664),i=t(1749),a=t(2318),c=(0,t(1120).Z)((function(e){return{sidebarSection:{marginTop:e.spacing(3)}}}));function o(e){var n=e.archives,t=e.topics,o=c();return(0,r.jsxs)(i.Z,{item:!0,xs:12,md:3,children:[(0,r.jsx)(a.Z,{variant:"h6",gutterBottom:!0,className:o.sidebarSection,children:"Archives"}),(0,r.jsx)("ul",{children:n.map((function(e){return(0,r.jsxs)("li",{children:[(0,r.jsx)(s.default,{href:e.url,children:e.title}),"\xa0",(0,r.jsxs)("span",{title:"posts count",children:["(",e.count,")"]})]},e.url)}))}),(0,r.jsx)(a.Z,{variant:"h6",gutterBottom:!0,className:o.sidebarSection,children:"Topics"}),(0,r.jsx)("ul",{children:t.map((function(e){return(0,r.jsxs)("li",{children:[(0,r.jsx)(s.default,{href:e.url,children:e.title}),"\xa0",(0,r.jsxs)("span",{title:"posts count",children:["(",e.count,")"]})]},e.url)}))})]})}},8132:function(e,n,t){"use strict";t.r(n),t.d(n,{__N_SSG:function(){return i},default:function(){return a}});var r=t(5893),s=t(8102),i=!0;function a(e){return(0,r.jsx)(s.Z,{posts:e.posts,pageNumber:e.pageNumber,pageURL:function(n){return"/month/".concat(e.month,"/page/").concat(n)},pagesCount:e.pages,archives:e.archives,topics:e.topics})}},6019:function(e,n,t){(window.__NEXT_P=window.__NEXT_P||[]).push(["/month/[month]/page/[page]",function(){return t(8132)}])}},function(e){e.O(0,[774,351,762,493],(function(){return n=6019,e(e.s=n);var n}));var n=e.O();_N_E=n}]);