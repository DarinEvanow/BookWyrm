import styled from 'styled-components';

export const Book = styled.div`
  display: flex;
  flex-direction: column;
  margin: 20px;
`;

export const BookImage = styled.img`
  width: 200px;
`;

export const BookList = styled.div`
  display: flex;
  flex-direction: row;
  height: 400px;
  width: 100vw;
  overflow-x: scroll;
`;
