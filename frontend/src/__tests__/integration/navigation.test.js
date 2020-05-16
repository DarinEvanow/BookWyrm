import React from 'react';
import { MockedProvider } from '@apollo/react-testing';
import { render, getByText, waitFor } from '@testing-library/react';
import waitForExpect from 'wait-for-expect';

import App from '../../App';
import client from '../../client';
import { GET_BOOKS_QUERY } from '../../components/home/HomeContainer';

const mocks = [
  {
    request: {
      query: GET_BOOKS_QUERY,
    },
    result: {
      data: {
        books: [{ __typename: 'Book', id: 1, title: 'The Name of the Wind' }],
      },
    },
  },
];

describe('when opening the application', () => {
  const { getByText } = render(
    <MockedProvider mocks={mocks} client={client}>
      <App />
    </MockedProvider>,
  );

  it('loads the users books', async () => {
    await waitFor(() => {
      expect(getByText('The Name of the Wind')).toBeTruthy();
    });
  });
});
