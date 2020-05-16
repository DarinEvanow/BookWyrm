export interface IBook {
  id: number;
  title: string;
  authors: IAuthor[];
}

export interface IAuthor {
  id: number;
  name: string;
}
