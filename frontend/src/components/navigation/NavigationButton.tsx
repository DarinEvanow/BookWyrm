import React from 'react';
import * as SC from './styles';

const NavigationButton: React.FC<{
  text: string;
  url: string;
  exact?: boolean;
}> = ({ text, exact, url, children }) => {
  return (
    <SC.NavigationButton exact={exact} to={url}>
      {children}
      {text}
    </SC.NavigationButton>
  );
};

export default NavigationButton;
