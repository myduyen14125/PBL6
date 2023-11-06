export interface SearchParams {
  page: number;
  limit: number;
  keyword: string;
  major: string;
  location: string;
  rating: number;
}

export interface CreateScheduleParams {
  start_at: string;
  end_at: string;
}

export interface GetPaginationParams {
  page: number;
  limit?: number;
}

export interface SearchMentorsParams {
  page: number;
  name: string;
  limit?: number;
}

export interface Mentor {
  _id: string;
  name: string;
  avatar: string;
  email: string;
  gender: boolean;
  number_of_mentees: number;
}
