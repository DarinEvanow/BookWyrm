import React from 'react';
import * as SC from './styles';
import NavigationButton from './NavigationButton';
import { User, Search, Book } from 'react-feather';

const Navigation: React.FC = () => {
  return (
    <SC.Navigation>
      <NavigationButton exact text="Home" url="/">
        <User />
      </NavigationButton>
      <NavigationButton text="Search" url="/search">
        <Search />
      </NavigationButton>
      <NavigationButton text="Library" url="/library">
        <Book />
      </NavigationButton>
    </SC.Navigation>
  );
};

export default Navigation;
