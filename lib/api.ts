export const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8000/api";
export const STORAGE_URL = process.env.NEXT_PUBLIC_STORAGE_URL || "http://localhost:8000/storage";
export const BACKEND_URL = process.env.NEXT_PUBLIC_BACKEND_URL || "http://localhost:8000";

export async function fetchPortfolioData() {
    try {
        const res = await fetch(`${API_URL}/portfolio`, {
            next: { revalidate: 60 } // Revalidate every 60 seconds
        });

        if (!res.ok) {
            throw new Error(`HTTP error! status: ${res.status}`);
        }

        return await res.json();
    } catch (error) {
        console.error('API Fetch Error:', error);
        return {
            profile: null,
            skills: [],
            projects: [],
            certifications: [],
            timeline: [],
            stats: []
        };
    }
}
