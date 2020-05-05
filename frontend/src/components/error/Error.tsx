import React from 'react';
import { ApolloError } from 'apollo-client/errors/ApolloError';

const Error: React.FC<{ error: ApolloError }> = () => {
  return <div>Error</div>;
};

export default Error;
