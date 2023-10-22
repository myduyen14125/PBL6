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

export interface GetMentorsParams {
  page: number;
  limit?: number;
}

export interface SearchMentorsParams {
  page: number;
  name: string;
  limit?: number;
}
