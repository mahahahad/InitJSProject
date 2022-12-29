#! /bin/bash
#
# Script to initialize a default javascript project

echo "# ${PWD##*/}" >> README.md

mkdir src dist
cd src
mkdir styles JS assets
cd styles
touch index.scss

# Include your custom stylesheet here
tee index.scss <<EOF
@use "mediaQueries";

@mixin fc(\$direction) {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: \$direction;
}

:root {
  \$tones: 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 99, 100;
  
  // Change this
  \$huePrimary: 70;
  \$hueNeutral: \$huePrimary + 180;
  
  \$toneOffset: "";
  @each \$tone in \$tones {
    @if \$tone < 90 {
      \$toneOffset: \$tone * 0.25;
    }
    --Neutral#{\$tone}: hsl(
      #{\$hueNeutral},
      #{\$toneOffset + "%"},
      #{\$tone + "%"}
    );
  }
  @each \$tone in \$tones {
    --Primary#{\$tone}: hsl(#{\$huePrimary}, #{\$tone + "%"}, #{\$tone + "%"});
  }

  --primary: var(--Primary80);
  --on-primary: var(--Primary20);
  --primary-container: var(--Primary30);
  --on-primary-container: var(--Primary90);
  --background: var(--Neutral10);
  --on-background: var(--Neutral99);
  --outline: var(--Neutral40);
}

*::before,
*::after,
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: sans-serif;
}

section {
  height: 100vh;
  width: 100vw;
}

body {
  background-color: var(--background);
  color: var(--on-background);
}
EOF
tee _mediaQueries.scss <<EOF
@media (prefers-color-scheme: light) {
  :root {
    --primary: var(--Primary40);
    --on-primary: white;
    --primary-container: var(--Primary90);
    --on-primary-container: var(--Primary10);
    --background: var(--Neutral99);
    --on-background: var(--Neutral10);
    --outline: var(--Neutral50);
  }
}
EOF
cd ..
cd JS
touch index.js
mkdir utils
cd ..
cd ..

touch index.html
tee index.html <<EOF
<!DOCTYPE HTML>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, intial-scale=1" />
    <meta name="color-scheme" content="dark light" />
    <link rel="stylesheet" href="./dist/index.css" />
    <title>${PWD##*/}</title>
  </head>
  <body>
    
    <script src="./src/JS/index.js"></script>
  </body>
</html>
EOF

# Requires you to have python installed
echo "python -m http.server" >> start_server.sh

# Requires you to have sass installed
echo "sass -w src/styles:dist/" >> start_sass_compiler.sh
