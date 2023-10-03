import type { RouteContext } from "../../types/auth";

export function middlewarePipeline(
  context: RouteContext,
  middleware: any,
  index: number
): () => void {
  const nextMiddleware = middleware[index];
  if (!nextMiddleware) {
    return context.next;
  }

  return () => {
    const nextPipeline = middlewarePipeline(context, middleware, index + 1);
    nextMiddleware({ ...context, next: nextPipeline });
  };
}
