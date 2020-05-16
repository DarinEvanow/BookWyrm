import styled, { createGlobalStyle } from 'styled-components';

export const GlobalStyle = createGlobalStyle`
  body {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
      'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
      sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }

  code {
    font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
      monospace;
  }
`;

export const App = styled.div`
  display: grid;
  height: 100vh;

  body {
    margin: 0;
  }

  @media screen and (min-width: 0px) {
    grid-template-areas:
      'content content content'
      'navigation navigation navigation';

    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 1fr 100px;
  }

  @media screen and (min-width: 800px) {
    grid-template-areas:
      'navigation content content'
      'navigation content content';

    grid-template-columns: 10% 1fr 1fr;
    grid-template-rows: 1fr 1fr;
  }
`;

export const Content = styled.div`
  grid-area: content;
`;
