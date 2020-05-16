import styled from 'styled-components';

export const Book = styled.div`
  display: flex;
  flex-direction: column;
`;

export const BookImage = styled.img`
  height: 300px;
  width: 200px;
`;

export const BookList = styled.div`
  display: flex;
  flex-direction: row;
  height: 400px;
  width: 100vw;
  overflow-x: scroll;
`;
