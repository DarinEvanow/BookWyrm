import styled from 'styled-components';
import { NavLink } from 'react-router-dom';

export const Navigation = styled.div`
  grid-area: navigation;
  background-color: #1b1b21;
  display: flex;
  align-items: center;
  justify-content: space-around;

  @media screen and (min-width: 0px) {
    flex-direction: row;
  }

  @media screen and (min-width: 800px) {
    flex-direction: column;
  }
`;

const activeClassName = 'nav-item-active';

export const NavigationButton = styled(NavLink).attrs({ activeClassName })`
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  color: white;

  &.${activeClassName} {
    color: #4ecdc4;
  }

  svg {
    height: 36px;
    width: 36px;
  }
`;
