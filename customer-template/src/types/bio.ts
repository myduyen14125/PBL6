export interface PostExperienceParams {
  bio: string;
  position: string;
  company: string;
  start_date: string | Date;
  end_date: string | Date;
  description: string;
}

export interface EducationParams {
  bio: string;
  place: string;
  major: string;
  start_date: string | Date;
  end_date: string | Date;
  description: string;
}

export interface AwardParams {
  bio: string;
  name: string;
  date: string | Date;
  description: string;
}

export interface SkillParams {
  bio: string;
  name: string;
  description: string;
}
