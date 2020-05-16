import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import HomeContainer from './components/home/HomeContainer';
import LibraryContainer from './components/library/LibraryContainer';
import SearchContainer from './components/search/SearchContainer';
import Navigation from './components/navigation/Navigation';
import * as SC from './styles';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <SC.App>
        <SC.Content>
          <Switch>
            <Route path="/" exact component={HomeContainer} />
            <Route path="/search" exact component={SearchContainer} />
            <Route path="/library" exact component={LibraryContainer} />
          </Switch>
        </SC.Content>
        <Navigation />
      </SC.App>
      <SC.GlobalStyle />
    </BrowserRouter>
  );
};

export default App;
