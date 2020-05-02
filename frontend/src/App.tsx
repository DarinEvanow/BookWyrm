import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import HomeContainer from './components/home/HomeContainer';
import LibraryContainer from './components/library/LibraryContainer';
import SearchContainer from './components/search/SearchContainer';
import Footer from './components/navigation/Footer';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <div id="app">
        <div id="content">
          <Switch>
            <Route path="/" exact component={HomeContainer} />
            <Route path="/library" exact component={LibraryContainer} />
            <Route path="/search" exact component={SearchContainer} />
          </Switch>
        </div>
        <Footer />
      </div>
    </BrowserRouter>
  );
};

export default App;
